package com.namastemart.utility;

import java.text.SimpleDateFormat;
import java.util.Date;

public class IDUtil {
    public static String generateId() {
        String pid = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
        pid = sdf.format(new Date());
        pid = "P" + pid;
        return pid;
    }

    public static String generateTransId() {
        String tid = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
        tid = sdf.format(new Date());
        tid = "T" + tid;
        return tid;
    }
}