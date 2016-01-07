package com.banvien.tpk.webapp.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtils {
    public static long HOUR = 3600000L;
    public static final Date addDate(Date d, int days) {
        Date res = new Date(d.getTime() + days * 24 * 3600000L);
        return res;
    }

    public static final String date2String(Date d, String format) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
        return simpleDateFormat.format(d);
    }

    public static final Date string2Date(String d, String format) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
        try {
            return simpleDateFormat.parse(d);
        } catch (ParseException e) {
            return null;
        }
    }


    public static int getWeekOfYear(Timestamp d) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(d.getTime()));

        return calendar.get(Calendar.WEEK_OF_YEAR);
    }


    public static Timestamp string2TimeStamp(String d, String formatDateTo, String formatDateFrom) {
        String auditDate = null;
        try
        {
            SimpleDateFormat sdf1 = new SimpleDateFormat(formatDateTo);
            Date date = sdf1.parse(d);
            SimpleDateFormat sdf2 = new SimpleDateFormat(formatDateFrom);
            auditDate = sdf2.format(date);
        }
        catch(Exception ex)
        {
            return null;
        }
        return Timestamp.valueOf(auditDate);
    }


    public static int getMonthOfYear(Timestamp d) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(d.getTime()));

        return calendar.get(Calendar.MONTH);

    }

    public static Timestamp move2TheEndOfDay(Timestamp input) {
		Timestamp res = null;
		if (input != null) {
			res = new Timestamp(input.getTime() + 24 * HOUR - 1000);
		}
		return res;
	}

    public static Timestamp move2NextDay(Timestamp input){
        Timestamp res = null;
        if (input != null) {
            res = new Timestamp(input.getTime() + 24 * HOUR);
        }
        return res;
    }

    public static String getDayOfWeek(Date d) {
        SimpleDateFormat dateformat = new SimpleDateFormat("EEEE");
        String dayInString = dateformat.format(d);
        return   dayInString;

    }

    public static int getDayOfMonth(Timestamp d) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(d.getTime()));
        return calendar.get(Calendar.DAY_OF_MONTH);
    }
    public static int getDayOfWeek(Timestamp d) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(d.getTime()));
        return calendar.get(Calendar.DAY_OF_WEEK);
    }
    public static int getYear(Timestamp d) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(d.getTime()));
        return calendar.get(Calendar.YEAR);
    }
}
