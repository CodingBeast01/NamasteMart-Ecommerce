package com.namastemart.beans;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import com.namastemart.utility.IDUtil;

@SuppressWarnings("serial")
public class TransactionBean implements Serializable {

    private String transactionId;
    private String userName;
    private Timestamp transDateTime;
    private double transAmount;
    private String status;

    public TransactionBean() {
        super();
        this.transactionId = IDUtil.generateTransId();
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD hh:mm:ss");
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        sdf.format(timestamp);
        this.transDateTime = timestamp;
        this.status = "paid";
    }

    public TransactionBean(String userName, double transAmount) {
        super();
        this.userName = userName;
        this.transAmount = transAmount;
        this.transactionId = IDUtil.generateTransId();
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD hh:mm:ss");
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        sdf.format(timestamp);
        this.transDateTime = timestamp;
        this.status = "paid";
    }

    public TransactionBean(String transactionId, String userName, double transAmount) {
        super();
        this.transactionId = transactionId;
        this.userName = userName;
        this.transAmount = transAmount;
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD hh:mm:ss");
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        sdf.format(timestamp);
        this.transDateTime = timestamp;
        this.status = "paid";
    }

    public TransactionBean(String userName, Timestamp transDateTime, double transAmount) {
        super();
        this.userName = userName;
        this.transDateTime = transDateTime;
        this.transactionId = IDUtil.generateTransId();
        this.transAmount = transAmount;
        this.status = "paid";
    }

    public TransactionBean(String transactionId, String userName, Timestamp transDateTime, double transAmount) {
        super();
        this.transactionId = transactionId;
        this.userName = userName;
        this.transDateTime = transDateTime;
        this.transAmount = transAmount;
        this.status = "paid";
    }

    public TransactionBean(String transactionId, String userName, Timestamp transDateTime, double transAmount, String status) {
        super();
        this.transactionId = transactionId;
        this.userName = userName;
        this.transDateTime = transDateTime;
        this.transAmount = transAmount;
        this.status = status;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Timestamp getTransDateTime() {
        return transDateTime;
    }

    public void setTransDateTime(Timestamp transDateTime) {
        this.transDateTime = transDateTime;
    }

    public double getTransAmount() {
        return transAmount;
    }

    public void setTransAmount(double transAmount) {
        this.transAmount = transAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}