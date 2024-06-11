package com.gdu.academix.service;

import java.util.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.academix.dto.AttendanceRecordDto;
import com.gdu.academix.mapper.AttendanceRecordMapper;

@Transactional
@Service
public class AttendanceServiceImpl implements AttendanceService {

  private final AttendanceRecordMapper attendancerecordMapper;
  
	public AttendanceServiceImpl(AttendanceRecordMapper attendancerecordMapper) {
		super();
		this.attendancerecordMapper = attendancerecordMapper;
	}

	@Override
	public int registerAttendanceRecord(Map<String, Object> params) throws ParseException {
		
    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HHmm");
    Date date = dateTimeFormat.parse((String) params.get("timeIn"));
    int timein = Integer.parseInt(timeFormat.format(date));
    int status = 1;
    if(timein > 900) {
    	status = 2;
    }
    
    AttendanceRecordDto attendancerecordDto = AttendanceRecordDto.builder()
        .recordDate(new Timestamp(date.getTime()))
        .timeIn(new Timestamp(date.getTime()))
        .employeeNo((int) params.get("employeeNo"))
        .status(status)
      .build();
  
    // DB에 event 저장	
    int insertCount = attendancerecordMapper.insertAttendanceRecord(attendancerecordDto);

    return insertCount;
	}

	@Override
	public ResponseEntity<Map<String, Object>> getAttendanceRecord(int employeeNo) {
    // 목록 화면으로 반환할 값 (목록)
		Map<String, Object> map = Map.of("recordList", attendancerecordMapper.getAttendanceRecordByemployeeNo(employeeNo));
    return new ResponseEntity<>(Map.of("recordList", attendancerecordMapper.getAttendanceRecordByemployeeNo(employeeNo))
                              , HttpStatus.OK);
	}

	@Override
	public int updateAttendanceRecord(Map<String, Object> params) throws ParseException {
		System.out.println(params);
		
    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    Date date = dateTimeFormat.parse((String) params.get("date"));
    Date timeIn;
    Date timeOut;
    int status;
    
    AttendanceRecordDto attendancerecordDto = AttendanceRecordDto.builder()
    		.recordNo((int) params.get("recordNo"))
    		.recordDate(new Timestamp(date.getTime()))
    		.employeeNo((int) params.get("employeeNo"))
  		.build();
    
    if(params.get("timeIn") != null) {
    	timeIn = dateTimeFormat.parse((String) params.get("timeIn"));
    	attendancerecordDto.setTimeIn(new Timestamp(timeIn.getTime()));
    }
    if(params.get("timeOut") != null) {
    	timeOut = dateTimeFormat.parse((String) params.get("timeOut"));
    	attendancerecordDto.setTimeOut(new Timestamp(timeOut.getTime()));
    }
    if(params.get("status") != null) {
    	status = (int) params.get("status");
    	attendancerecordDto.setStatus(status);
    }
    
    // DB에 event 저장	
    int insertCount = attendancerecordMapper.updateAttendanceRecord(attendancerecordDto);

    return insertCount;
	}

	@Override
	public int removeAttendanceRecord(int recordNo) {
    // event 삭제
    return attendancerecordMapper.removeAttendanceRecord(recordNo);
	}


  
}
