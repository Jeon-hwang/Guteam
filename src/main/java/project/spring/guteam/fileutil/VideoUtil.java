package project.spring.guteam.fileutil;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

public class VideoUtil {
	private static final Logger logger = LoggerFactory.getLogger(VideoUtil.class);
	
	@Resource(name="uploadPath")
	private static String uploadPath;
	
	public static String upload(MultipartFile multipartFile, int gameId) {
		logger.info("### upload");
		String extention = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf('.')+1);
		File targetFile = new File(uploadPath + gameId + extention);
		InputStream fileStream;
		try {
			fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);
			e.printStackTrace();
		}
		return targetFile.getName();
	}
}
