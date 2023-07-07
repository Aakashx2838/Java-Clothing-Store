package com.mephx.utils;

import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class ImageUploadHandler {
    public String saveUploadedImage(Part filePart, String savePath, String uploadPath) throws IOException {
        File folder1 = new File(savePath);
        if (!folder1.exists()){
            folder1.mkdirs();
        }
        File folder2 = new File(uploadPath);
        if (!folder2.exists()){
            folder2.mkdirs();
        }
        String fileName = filePart.getSubmittedFileName();
        InputStream fileContent = filePart.getInputStream();
        file_output_stream(fileName, fileContent, uploadPath);
        return savePath + fileName;
    }

    private void file_output_stream(String fileName, InputStream fileContent, String uploadPath) throws IOException {
        FileOutputStream outputStream = new FileOutputStream(uploadPath + fileName);
        byte[] buffer = new byte[4096];
        int bytesRead = -1;
        while ((bytesRead = fileContent.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }

        fileContent.close();
        outputStream.close();
    }

    public List<String> saveUploadedImageArray(List<Part> fileParts, String savePath, String uploadPath) throws IOException {
        File folder1 = new File(savePath);
        if (!folder1.exists()){
            folder1.mkdirs();
        }
        File folder2 = new File(uploadPath);
        if (!folder2.exists()){
            folder2.mkdirs();
        }

        List<String> savedFiles = new ArrayList<>();

        for (Part filePart : fileParts) {
            String fileName = filePart.getSubmittedFileName();
            InputStream fileContent = filePart.getInputStream();
            if (fileName != null && !fileName.isEmpty()) {
                file_output_stream(fileName, fileContent, uploadPath);
                savedFiles.add(savePath + fileName);
            }
        }

        return savedFiles;
    }
}
