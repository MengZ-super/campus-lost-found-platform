package com.campus.finder.controller;

import com.campus.finder.common.result.Result;
import com.campus.finder.service.FileStorageService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@Tag(name = "文件上传", description = "文件上传接口")
@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
@SecurityRequirement(name = "Bearer")
public class FileController {

    private final FileStorageService fileStorageService;

    @Operation(summary = "上传文件", description = "上传文件到 MinIO")
    @PostMapping("/upload")
    public Result<String> upload(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return Result.error("文件不能为空");
        }

        String contentType = file.getContentType();
        if (contentType == null || (!contentType.equals("image/jpeg") && !contentType.equals("image/png"))) {
            return Result.error("仅支持 JPG/PNG 格式");
        }

        if (file.getSize() > 5 * 1024 * 1024) {
            return Result.error("文件大小不能超过 5MB");
        }

        String url = fileStorageService.upload(file);
        return Result.success("上传成功", url);
    }
}
