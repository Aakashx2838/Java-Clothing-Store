package com.mephx.database;

public class DBCredentials {
    private static final String DB_NAME = "mephx_store";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";

    public static String getDbName() {
        return DB_NAME;
    }

    public static String getDbUsername() {
        return DB_USERNAME;
    }

    public static String getDbPassword() {
        return DB_PASSWORD;
    }
}
