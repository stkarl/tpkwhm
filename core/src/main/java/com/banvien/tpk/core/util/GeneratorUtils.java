package com.banvien.tpk.core.util;
import com.banvien.tpk.core.Constants;

public class GeneratorUtils {
    public static long MAX_PNK_PL_UID = 0l;
    public static long MAX_PXK_PL_UID = 0l;

    public static long MAX_PXK_TON_UID = 0l;
    public static long MAX_PNK_TON_UID = 0l;

    public static long MAX_PTN_TON_UID = 0l;

    public static long MAX_BB_UID = 0l;


    public static String generatePTNTCode(){
        Long res = MAX_PTN_TON_UID + 1;
        MAX_PTN_TON_UID = MAX_PTN_TON_UID + 1;
        return  Constants.PTN_PREFIX + res.toString();
    }

    public static String generatePNKPLCode(){
        Long res = MAX_PNK_PL_UID + 1;
        MAX_PNK_PL_UID = MAX_PNK_PL_UID + 1;
        return  Constants.PNK_PREFIX + res.toString();
    }

    public static String generatePXKPLCode(){
        Long res = MAX_PXK_PL_UID + 1;
        MAX_PXK_PL_UID = MAX_PXK_PL_UID + 1;
        return  Constants.PXK_PREFIX + res.toString();
    }

    public static String generatePNKTONCode(){
        Long res = MAX_PNK_TON_UID + 1;
        MAX_PNK_TON_UID = MAX_PNK_TON_UID + 1;
        return  Constants.PNK_PREFIX + res.toString();
    }

    public static String generatePXKTONCode(){
        Long res = MAX_PXK_TON_UID + 1;
        MAX_PXK_TON_UID = MAX_PXK_TON_UID + 1;
        return  Constants.PXK_PREFIX + res.toString();
    }

    public static String getLatestBookNumber() {
        Long res = MAX_BB_UID + 1;
        MAX_BB_UID = MAX_BB_UID + 1;
        return  res.toString();
    }
}
