package com.banvien.tpk.core.util;

/**
 * User: BAN
 * Date: 7/5/12
 * Time: 3:55 PM
 */
public class GpsUtil {
    //calculate distance between two gps points, return unit is meters
    public static double distFrom(float lat1, float lng1, float lat2, float lng2) {
        double earthRadius = 6371;//km
        double dLat = Math.toRadians(lat2-lat1);
        double dLng = Math.toRadians(lng2-lng1);
        double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                   Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
                   Math.sin(dLng/2) * Math.sin(dLng/2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        double dist = earthRadius * c;

        return dist * 1000;
    }
}
