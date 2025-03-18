package com.fsoft.converter;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import com.fsoft.dto.TableUserDTO;
import com.fsoft.entity.TableUserEntity;



@Component
public class TableUserConverter {

    
	private final ModelMapper modelMapper = new ModelMapper();

	private static final Logger logger = Logger.getLogger(TableUserConverter.class);

	public TableUserDTO toDto(TableUserEntity entity) {
		if (entity != null) {
			return modelMapper.map(entity, TableUserDTO.class);
		} else {
			return null;
		}
	}

	public TableUserEntity toEntity(TableUserDTO dto) {
		if (dto != null) {
			return modelMapper.map(dto, TableUserEntity.class);
		} else {
			return null;
		}
	}
	

	
	public static final int COLUMN_INDEX_NAME = 0;
    public static final int COLUMN_INDEX_STATUS = 1;
    public static final int COLUMN_INDEX_GROUP = 2;
    public static final int COLUMN_INDEX_CHAIR = 3;
    public static final int COLUMN_INDEX_INDEX = 4;
    public static final int COLUMN_INDEX_NOTE = 5;

    public List<TableUserDTO> parseExcelFile(InputStream inputStream) {
        List<TableUserDTO> tableUserList = new ArrayList<>();

        try (Workbook workbook = new XSSFWorkbook(inputStream)) {
            Sheet sheet = workbook.getSheetAt(0);
            if (sheet == null) {
                throw new Exception("Sheet is empty or not found.");
            }
            
            Iterator<Row> iterator = sheet.iterator();
            while (iterator.hasNext()) {
                Row row = iterator.next();
                if (row.getRowNum() == 0) {
                    // Ignore header
                    continue;
                }
                
                if (row.getCell(COLUMN_INDEX_NAME).getStringCellValue() == null || row.getCell(0).getStringCellValue().isBlank() || row.getCell(0).getStringCellValue().isEmpty()) {
                    continue;
                }

                TableUserDTO dto = new TableUserDTO();
                
                // Assuming the cells exist and have valid types.
                try {
					dto.setTableUserName(row.getCell(COLUMN_INDEX_NAME).getStringCellValue());
				} catch (Exception e) {
					logger.error("Error reading table user name", e);
					dto.setTableUserName(""); // Default value or handle as needed
				}

				try {
					dto.setTableUserStatus((int) row.getCell(COLUMN_INDEX_STATUS).getNumericCellValue());
				} catch (Exception e) {
					logger.error("Error reading table user status", e);
					dto.setTableUserStatus(0); 
				}

				try {
					dto.setTableUserGroup(row.getCell(COLUMN_INDEX_GROUP).getStringCellValue());
				} catch (Exception e) {
					logger.error("Error reading table user group", e);
					dto.setTableUserGroup("");
				}

				try {
					dto.setTableNumberOfChair(String.valueOf((int)row.getCell(COLUMN_INDEX_CHAIR).getNumericCellValue()));
				} catch (Exception e) {
					logger.error("Error reading table number of chair", e);
					dto.setTableNumberOfChair(""); 
				}

				try {
					dto.setTableUserIndex((int) row.getCell(COLUMN_INDEX_INDEX).getNumericCellValue());
				} catch (Exception e) {
					logger.error("Error reading table user index", e);
					dto.setTableUserIndex(0); 
				}

				try {
					dto.setTableUserNote(row.getCell(COLUMN_INDEX_NOTE).getStringCellValue());
				} catch (Exception e) {
					logger.error("Error reading table user note", e);
					dto.setTableUserNote(""); 
				}

                tableUserList.add(dto);
            }
        } catch (IOException e) {
            e.printStackTrace(); 
        } catch (Exception e) {
            e.printStackTrace(); 
        }

        return tableUserList;
    }

	public List<TableUserDTO> toListDTO(List<TableUserEntity> userEntities) {
		// TODO Auto-generated method stub
		List<TableUserDTO> tableUserDTOs  = new ArrayList<>();
		for (TableUserEntity entity : userEntities) {
			tableUserDTOs.add(toDto(entity));
		}
		return tableUserDTOs;
	}
	
	public List<TableUserEntity> toListEntity(List<TableUserDTO> tableUserDTOs) {
		// TODO Auto-generated method stub
		List<TableUserEntity> tableUserEntities = new ArrayList<>();
		for (TableUserDTO tableUserDTO : tableUserDTOs) {
			tableUserEntities.add(toEntity(tableUserDTO));
		}
		return tableUserEntities;
	}



}
