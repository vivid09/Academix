package com.gdu.academix.utils;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.springframework.stereotype.Component;

@Component
public class MyDateParseUtils {

  public static Timestamp parseTimestamp(String dateStr, SimpleDateFormat dateTimeFormat, SimpleDateFormat dateOnlyFormat) throws ParseException {
    try {
        return new Timestamp(dateTimeFormat.parse(dateStr).getTime());
    } catch (ParseException e) {
        return new Timestamp(dateOnlyFormat.parse(dateStr).getTime());
    }
}
  
}