package com.fsoft.api.customer;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fsoft.converter.TableOrderConverter;
import com.fsoft.dto.BaseDTO;
import com.fsoft.dto.CategoryDTO;
import com.fsoft.dto.ProductDTO;
import com.fsoft.dto.TableOrderDTO;
import com.fsoft.dto.TableUserDTO;
import com.fsoft.response.CheckOrderResponse;
import com.fsoft.response.OrderResponse;
import com.fsoft.response.ResponseAPI;
import com.fsoft.response.TableOrderResponse;
import com.fsoft.service.ICategoryService;
import com.fsoft.service.IOrderService;
import com.fsoft.service.IProductService;
import com.fsoft.service.ITableOrderService;
import com.fsoft.service.ITableUserService;

@RestController
@RequestMapping("/api/customer")
public class HomeAPICustomer {
    
    private static final Logger logger = Logger.getLogger(HomeAPICustomer.class);
    
    @Autowired
    private ITableUserService tableUserService;
    
    @Autowired
    private ICategoryService categoryService;
    
    @Autowired
    private IProductService productService;
    
    @Autowired
    private ITableOrderService tableOrderService;
    
    @Autowired
    private IOrderService orderService;
    
    @Autowired
    private TableOrderConverter tableOrderConverter;

    @PostMapping("/put-order-table")
    public ResponseAPI<List<TableOrderDTO>> putOrderTemporary(HttpServletRequest request, @RequestBody TableOrderResponse tableOrderResponse) {
        try {
            HttpSession session = request.getSession(true);
            Map<Integer, List<TableOrderDTO>> tempOrders = (Map<Integer, List<TableOrderDTO>>) session.getAttribute("TEMP_ORDERS");

            if (tempOrders == null) {
                tempOrders = new HashMap<>();
            }

            int tableId = tableOrderResponse.getUserTableID();
            TableOrderDTO newOrder = tableOrderConverter.convertToDTO(tableOrderResponse);

            List<TableOrderDTO> orders = tempOrders.getOrDefault(tableId, new ArrayList<>());
            
            // Check if product already exists in order
            boolean productExists = false;
            for (TableOrderDTO order : orders) {
                if (order.getProduct().getProductId() == tableOrderResponse.getProductId()) {
                    order.setOrderQuantity(order.getOrderQuantity() + tableOrderResponse.getOrderQuantity());
                    productExists = true;
                    break;
                }
            }
            
            if (!productExists) {
                orders.add(newOrder);
            }
            
            tempOrders.put(tableId, orders);
            session.setAttribute("TEMP_ORDERS", tempOrders);

            return new ResponseAPI<>(HttpStatus.OK.value(), "Đã lưu tạm món ăn cho bàn " + tableId, orders);
        } catch (Exception e) {
            logger.error("Error in putOrderTemporary: " + e.getMessage(), e);
            return new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi khi lưu đơn hàng tạm: " + e.getMessage(), null);
        }
    }

    @PutMapping("/put-order")
    public ResponseAPI<?> putOrder(HttpServletRequest request, @RequestBody OrderResponse orderResponse) {
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                Map<Integer, List<TableOrderDTO>> tempOrders = (Map<Integer, List<TableOrderDTO>>) session.getAttribute("TEMP_ORDERS");
                int tableId = orderResponse.getUserTableID();

                if (tempOrders != null && tempOrders.containsKey(tableId)) {
                    List<TableOrderDTO> orders = tempOrders.get(tableId);
                    List<TableOrderDTO> allSavedOrders = new ArrayList<>();
                    
                    // Lưu từng món một vào database
                    for (TableOrderDTO order : orders) {
                        TableOrderResponse tableOrderResponse = new TableOrderResponse();
                        tableOrderResponse.setUserTableID(tableId);
                        tableOrderResponse.setProductId(order.getProduct().getProductId());
                        tableOrderResponse.setOrderQuantity(order.getOrderQuantity());
                        
                        List<TableOrderDTO> savedOrders = tableUserService.handleTableOrder(tableOrderResponse);
                        if (savedOrders != null) {
                            allSavedOrders.addAll(savedOrders);
                        }
                    }
                    
                    // Xóa khỏi session sau khi lưu thành công
                    tempOrders.remove(tableId);
                    session.setAttribute("TEMP_ORDERS", tempOrders);
                  
                    
                    return new ResponseAPI<>(HttpStatus.OK.value(), "Thanh toán thành công và đã lưu đơn!", allSavedOrders);
                }
            }

            return new ResponseAPI<>(HttpStatus.BAD_REQUEST.value(), "Không tìm thấy đơn hàng để thanh toán!", null);
        } catch (Exception e) {
            logger.error("Error in putOrder: " + e.getMessage(), e);
            return new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Có Lỗi Bên Trong Server!", null);
        }
    }

    @GetMapping("/check-order")
    public ResponseAPI<?> checkOrderGet(HttpServletRequest request, @RequestParam(value = "userTableID", required = false) Integer userTableID) {
        try {
            if (userTableID == null) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    userTableID = (Integer) session.getAttribute("ACTIVE_TABLE_ID");
                }
            }
            
            if (userTableID == null) {
                return new ResponseAPI<>(HttpStatus.BAD_REQUEST.value(), "Vui lòng chọn bàn trước khi kiểm tra!", null);
            }
            
            return checkOrderInternal(request, userTableID);
        } catch (Exception e) {
            logger.error("Error in checkOrderGet: " + e.getMessage(), e);
            return new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Có Lỗi Bên Trong Server!", null);
        }
    }

    @PostMapping("/check-order")
    public ResponseAPI<?> checkOrderPost(HttpServletRequest request, @RequestBody OrderResponse orderResponse) {
        try {
            Integer userTableID = orderResponse.getUserTableID();
            
            HttpSession session = request.getSession(true);
            session.setAttribute("ACTIVE_TABLE_ID", userTableID);
            
            return checkOrderInternal(request, userTableID);
        } catch (Exception e) {
            logger.error("Error in checkOrderPost: " + e.getMessage(), e);
            return new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Có Lỗi Bên Trong Server!", null);
        }
    }

    private CheckOrderResponse getOrdersFromSession(HttpSession session, Integer tableId) {
        if (session == null) return null;
        
        Map<Integer, List<TableOrderDTO>> tempOrders = (Map<Integer, List<TableOrderDTO>>) session.getAttribute("TEMP_ORDERS");
        if (tempOrders == null || !tempOrders.containsKey(tableId)) return null;
        
        List<TableOrderDTO> orders = tempOrders.get(tableId);
        if (orders == null || orders.isEmpty()) return null;
        
        int totalQuantity = 0;
        BigDecimal totalPrice = BigDecimal.ZERO;
        
        for (TableOrderDTO order : orders) {
            totalQuantity += order.getOrderQuantity();
            if (order.getProduct() != null && order.getProduct().getProductPrice() != null) {
                BigDecimal quantity = new BigDecimal(order.getOrderQuantity());
                BigDecimal price = BigDecimal.valueOf(order.getProduct().getProductPrice());
                totalPrice = totalPrice.add(quantity.multiply(price));
            }
        }
        
        CheckOrderResponse response = new CheckOrderResponse();
        response.setTableOrder(orders);
        response.setTotalQuantity(totalQuantity);
        response.setTotalProductPrice(totalPrice);
        return response;
    }

    private ResponseAPI<?> checkOrderInternal(HttpServletRequest request, Integer userTableID) {
        try {
            HttpSession session = request.getSession(false);
            CheckOrderResponse sessionOrders = getOrdersFromSession(session, userTableID);
            
            if (sessionOrders != null) {
                return new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công!", sessionOrders);
            }
            
            CheckOrderResponse dbOrders = orderService.checkOrder(userTableID);
            if (dbOrders == null || dbOrders.getTableOrder() == null || dbOrders.getTableOrder().isEmpty()) {
                return new ResponseAPI<>(HttpStatus.OK.value(), "Bàn chưa có món nào!", null);
            }
            
            return new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công!", dbOrders);
        } catch (Exception e) {
            logger.error("Error in checkOrderInternal: " + e.getMessage(), e);
            return new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Có Lỗi Bên Trong Server!", null);
        }
    }

    @GetMapping("/init-data-table-order")
    public ResponseAPI<List<TableOrderDTO>> initDataTableOrder(HttpServletRequest request) {
        try {
            List<TableOrderDTO> allOrders = new ArrayList<>();
            
            HttpSession session = request.getSession(false);
            if (session != null) {
                Map<Integer, List<TableOrderDTO>> tempOrders = (Map<Integer, List<TableOrderDTO>>) session.getAttribute("TEMP_ORDERS");
                if (tempOrders != null) {
                    for (List<TableOrderDTO> tableOrders : tempOrders.values()) {
                        allOrders.addAll(tableOrders);
                    }
                }
            }
            
            List<TableOrderDTO> paidOrders = tableOrderService.findAll();
            if (paidOrders != null) {
                allOrders.addAll(paidOrders);
            }
            
            return new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công!", allOrders);
        } catch (Exception e) {
            logger.error("Error in initDataTableOrder: " + e.getMessage(), e);
            return new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Có Lỗi Bên Trong Server!", null);
        }
    }

    @GetMapping("/init-data-header-table-order")
    public ResponseAPI<?> initDataHeaderTableOrder(HttpServletRequest request) {
        try {
            List<TableUserDTO> tableUserDTOs = tableUserService.getListTableActive();
            
            HttpSession session = request.getSession(false);
            if (session != null) {
                Map<Integer, List<TableOrderDTO>> tempOrders = (Map<Integer, List<TableOrderDTO>>) session.getAttribute("TEMP_ORDERS");
                if (tempOrders != null) {
                    for (TableUserDTO table : tableUserDTOs) {
                        if (tempOrders.containsKey(table.getUserTableID())) {
                            table.setTableUserStatus(1);
                        }
                    }
                }
            }
            
            return new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công!", tableUserDTOs);
        } catch (Exception e) {
            logger.error("Error in initDataHeaderTableOrder: " + e.getMessage(), e);
            return new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Có Lỗi Bên Trong Server!", null);
        }
    }

    @GetMapping("/load-category")
    public ResponseAPI<List<CategoryDTO>> loadCategory() {
        try {
            List<CategoryDTO> categoryDTOs = categoryService.findAll();
            return new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công!", categoryDTOs);
        } catch (Exception e) {
            logger.error("Error in loadCategory: " + e.getMessage(), e);
            return new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Có Lỗi Bên Trong Server!", null);
        }
    }

    @GetMapping("/data-product")
    public ResponseEntity<ResponseAPI<BaseDTO<ProductDTO>>> getDataProduct(
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "limit", defaultValue = "10") int limit,
            @RequestParam(name = "idcategory", defaultValue = "") List<Integer> idcategory,
            @RequestParam(name = "search", defaultValue = "") String keysearch) {
        try {
            BaseDTO<ProductDTO> baseDTO = new BaseDTO<>();
            baseDTO.setPage(page);
            baseDTO.setLimit(limit);
            baseDTO.setTotalItem(productService.getTotalItem(idcategory, keysearch));
            baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
            
            Pageable pageable = new PageRequest(page - 1, limit);
            baseDTO.setListResult(productService.findAllByCategoryIdsAndKeysearch(idcategory, keysearch, pageable));

            return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công!", baseDTO));
        } catch (Exception e) {
            logger.error("Error in getDataProduct: " + e.getMessage(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
        }
    }

    @GetMapping("/data-table-user")
    public ResponseEntity<ResponseAPI<BaseDTO<TableUserDTO>>> getDataTableUser(
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "limit", defaultValue = "10") int limit,
            @RequestParam(name = "tableUserGroup", defaultValue = "All") String tableUserGroup,
            @RequestParam(name = "tableUserStatus", defaultValue = "2") int tableUserStatus) {
        try {
            BaseDTO<TableUserDTO> baseDTO = new BaseDTO<>();
            baseDTO.setPage(page);
            baseDTO.setLimit(limit);
            baseDTO.setTotalItem(tableUserService.getTotalItem(tableUserGroup, tableUserStatus));
            baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
            
            Pageable pageable = new PageRequest(page - 1, limit);
            baseDTO.setListResult(tableUserService.findAll(pageable, tableUserGroup, tableUserStatus));

            return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công!", baseDTO));
        } catch (Exception e) {
            logger.error("Error in getDataTableUser: " + e.getMessage(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
        }
    }

    @PutMapping("/put-quantity-item-order")
    public ResponseAPI<?> putQuantityItemOrder(@RequestBody TableOrderResponse tableOrderResponse) {
        try {
            tableOrderService.updateQantityItemOrder(tableOrderResponse);
            return new ResponseAPI<>(HttpStatus.OK.value(), "Cập Nhật Số Lượng Thành Công!", null);
        } catch (Exception e) {
            logger.error("Error in putQuantityItemOrder: " + e.getMessage(), e);
            return new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Có Lỗi Bên Trong Server!", null);
        }
    }

    @DeleteMapping("/delete-item-order")
    public ResponseAPI<?> deleteItemOrder(@RequestBody TableOrderResponse tableOrderResponse) {
        try {
            tableOrderService.deleteItemOrder(tableOrderResponse.getTableOrderId());
            return new ResponseAPI<>(HttpStatus.OK.value(), "Đã Xóa Thành Công!", null);
        } catch (Exception e) {
            logger.error("Error in deleteItemOrder: " + e.getMessage(), e);
            return new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Có Lỗi Bên Trong Server!", null);
        }
    }

    @GetMapping("/update-status-table")
    public ResponseEntity<ResponseAPI<?>> updateStatusTable(
            @RequestParam(name = "userTableID") int userTableID,
            @RequestParam(name = "tableUserStatus") int tableUserStatus) {
        try {
            tableUserService.updateStatus(userTableID, tableUserStatus);
            return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công!", null));
        } catch (Exception e) {
            logger.error("Error in updateStatusTable: " + e.getMessage(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
        }
    }
} 