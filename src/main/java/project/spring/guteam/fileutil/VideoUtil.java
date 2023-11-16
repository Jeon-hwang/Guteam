package project.spring.guteam.fileutil;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class VideoUtil {
	private static final Logger logger = LoggerFactory.getLogger(VideoUtil.class);
	
	private static final String uploadPath = "C:\\Study\\FileUploadTest";
		
	public static String upload(MultipartFile multipartFile, int gameId) {
		logger.info("### upload");
		logger.info(uploadPath);
		String extention = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf('.')+1);
		File targetFile = new File(uploadPath + File.separator, gameId + "." + extention);
				
		try 
			(InputStream fileStream = multipartFile.getInputStream();
			OutputStream outputStream = new FileOutputStream(targetFile)){
			FileCopyUtils.copy(fileStream, outputStream);
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);
			e.printStackTrace();
		}
		return targetFile.getName();
	}
}
