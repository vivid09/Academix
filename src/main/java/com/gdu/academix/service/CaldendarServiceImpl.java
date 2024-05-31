package com.gdu.academix.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.academix.dto.EventDto;
import com.gdu.academix.mapper.EventMapper;
import com.gdu.academix.utils.MyDateParseUtils;

import jakarta.servlet.http.HttpServletRequest;

@Transactional
@Service
public class CaldendarServiceImpl implements CalendarService {

  private final EventMapper eventMapper;
  
	public CaldendarServiceImpl(EventMapper eventMapper) {
		super();
		this.eventMapper = eventMapper;
	}

	@Override
	public int registerEvent(Map<String, Object> params) throws ParseException {
		System.out.println(params);
		
    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    SimpleDateFormat dateOnlyFormat = new SimpleDateFormat("yyyy-MM-dd'T'");

    EventDto eventDto = EventDto.builder()
              .title((String) params.get("title"))
              .backgroundColor((String) params.get("backgroundColor"))
              .textColor((String) params.get("textColor"))
              .location((String) params.get("location"))
              .description((String) params.get("description"))
              .start(MyDateParseUtils.parseTimestamp((String) params.get("start"), dateTimeFormat, dateOnlyFormat))
              .end(MyDateParseUtils.parseTimestamp((String) params.get("end"), dateTimeFormat, dateOnlyFormat))
              .ownerNo(1)
              .allDay((boolean) params.get("allDay"))
              .lat((String) params.get("lat"))
              .lng((String) params.get("lng"))
            .build();
  
    // DB에 event 저장	
    int insertCount = eventMapper.insertEvent(eventDto);

    return insertCount;
	}

	@Override
	public ResponseEntity<Map<String, Object>> getEventList(HttpServletRequest request) {
    // 목록 화면으로 반환할 값 (목록 + 전체 페이지 수)
		Map<String, Object> map = Map.of("eventList", eventMapper.getEventListByOwnerNo(1));
    return new ResponseEntity<>(Map.of("eventList", eventMapper.getEventListByOwnerNo(1))
                              , HttpStatus.OK);
	}

	@Override
	public int updateEvent(Map<String, Object> params) throws ParseException {
		System.out.println(params);
		
    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    SimpleDateFormat dateOnlyFormat = new SimpleDateFormat("yyyy-MM-dd'T'");

    EventDto eventDto = EventDto.builder()
    					.eventNo(Integer.parseInt((String) params.get("eventNo")))
              .title((String) params.get("title"))
              .backgroundColor((String) params.get("backgroundColor"))
              .textColor((String) params.get("textColor"))
              .location((String) params.get("location"))
              .description((String) params.get("description"))
              .start(MyDateParseUtils.parseTimestamp((String) params.get("start"), dateTimeFormat, dateOnlyFormat))
              .end(MyDateParseUtils.parseTimestamp((String) params.get("end"), dateTimeFormat, dateOnlyFormat))
              .ownerNo(1)
              .allDay((boolean) params.get("allDay"))
              .lat((String) params.get("lat"))
              .lng((String) params.get("lng"))
            .build();
    
    // DB에 event 저장	
    int insertCount = eventMapper.updateEvent(eventDto);

    return insertCount;
	}

	@Override
	public int removeEvent(int eventNo) {
    // event 삭제
    return eventMapper.removeEvent(eventNo);
	}


  
}
