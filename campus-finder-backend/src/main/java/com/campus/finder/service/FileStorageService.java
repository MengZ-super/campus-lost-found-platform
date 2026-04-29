package com.campus.finder.service;

import com.campus.finder.config.MinioConfig;
import io.minio.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class FileStorageService {

    private final MinioClient minioClient;
    private final MinioConfig minioConfig;

    public String upload(MultipartFile file) {
        String bucket = minioConfig.getBucket();
        String ext = getExtension(file.getOriginalFilename());
        String objectName = UUID.randomUUID().toString().replace("-", "") + ext;

        try {
            ensureBucket(bucket);

            minioClient.putObject(PutObjectArgs.builder()
                    .bucket(bucket)
                    .object(objectName)
                    .stream(file.getInputStream(), file.getSize(), -1)
                    .contentType(file.getContentType())
                    .build());

            return minioConfig.getEndpoint() + "/" + bucket + "/" + objectName;
        } catch (Exception e) {
            log.error("MinIO upload failed", e);
            throw new RuntimeException("文件上传失败", e);
        }
    }

    private void ensureBucket(String bucket) throws Exception {
        boolean exists = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucket).build());
        if (!exists) {
            minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucket).build());
            String policy = """
                    {
                      "Version": "2012-10-17",
                      "Statement": [
                        {
                          "Effect": "Allow",
                          "Principal": "*",
                          "Action": ["s3:GetObject"],
                          "Resource": ["arn:aws:s3:::%s/*"]
                        }
                      ]
                    }
                    """.formatted(bucket);
            minioClient.setBucketPolicy(
                    SetBucketPolicyArgs.builder().bucket(bucket).config(policy).build());
        }
    }

    private String getExtension(String filename) {
        if (filename == null) return ".jpg";
        int i = filename.lastIndexOf('.');
        return i >= 0 ? filename.substring(i) : ".jpg";
    }
}
