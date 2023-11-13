package project.spring.guteam.fileutil;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class GameImageUploadUtil {
	private static final Logger logger =
			LoggerFactory.getLogger(GameImageUploadUtil.class);
	
	public static String saveUploadedFile(String uploadPath, 
			String fileName, byte[] data) throws IOException {
				
		String saveName = fileName;		
		
		File target = new File(uploadPath + File.separator ,
				saveName);
		
		FileCopyUtils.copy(data, target); // data 를 uploadPath 에 fileName 으로 저장
		
		String extension = fileName.substring(fileName.lastIndexOf(".") + 1); // 확장자
		
		String result = null;
		if (MediaUtil.getMediaType(extension) != null) {
			result = createThumbnail(uploadPath, saveName);
		} else {
			result = createIcon(uploadPath, saveName);
		}
		
		return result;
	} // end saveUploadedFile()
	
	
	private static String createThumbnail(String uploadPath
			, String fileName) throws IOException {
		
		String parent = uploadPath;
		BufferedImage source = 
				ImageIO.read(new File(parent, fileName));
		BufferedImage destination = 
				Scalr.resize(source, Scalr.Method.AUTOMATIC, 
						Scalr.Mode.FIT_TO_HEIGHT, 300);
		String thumbnailName = 
				uploadPath + File.separator
				+ "s_" + fileName;
		File thumbnail = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf('.') + 1);
		
		boolean result = ImageIO.write(destination, formatName, thumbnail);
		logger.info("create thumbnail result: " + result);
		
		return thumbnailName.substring(uploadPath.length())
				.replace(File.separatorChar, '/');
	}
	
	private static String createIcon(String uploadPath,
			String fileName) {
		
		String iconName = uploadPath + File.separator 
				+ fileName;
		
		return iconName
				.substring(uploadPath.length())
				.replace(File.separatorChar, '/');
		
	}
	
} // end GameImageUploadUtil
