package com.banvien.tpk.core.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * User: BAN
 * Date: 6/18/12
 * Time: 2:36 PM
 */
public class CalendarUtil {
    public static final String defaultFormat = "dd/MM/yyyy hh:mm:ss";
    public static Date stringToDate(String strDate, String pattern) {
        DateFormat df = new SimpleDateFormat(pattern);
        try {
            return df.parse(strDate);
        } catch (Exception e) {
           //nothing
        }
        return null;
    }

    public static Date stringToDate(String strDate) {
        return  stringToDate(strDate,defaultFormat);
    }

    public static String dateToString(Date date) {
        DateFormat df = new SimpleDateFormat(defaultFormat);
        return  df.format(date);
    }

    public static String dateToString(Date date, String format) {
        DateFormat df = new SimpleDateFormat(format);
        return  df.format(date);
    }

    public static Date addMonth(Date d, int month) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(d);
        calendar.add(Calendar.MONTH, month);
        return calendar.getTime();
    }

}
