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
		// uploadPath 에 있는 fileName 파일을 source 에 담아 초기화
		BufferedImage destination = 
				Scalr.resize(source, Scalr.Method.AUTOMATIC, 
						Scalr.Mode.FIT_TO_HEIGHT, 300);
		// source 를 300 높이에 맞게 resize하여 destination 에 담아 초기화
		String thumbnailName = 
				uploadPath + File.separator
				+ "s_" + fileName;
		// 섬네일 이름을 같은 경로에 s_ 를 붙이는 것으로 지정하여 생성
		File thumbnail = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf('.') + 1);
		// 확장자를 가져와서 섬네일 파일을 write
		boolean result = ImageIO.write(destination, formatName, thumbnail);
		logger.info("create thumbnail result: " + result);
		
		return thumbnailName.substring(uploadPath.length())
				.replace(File.separatorChar, '/');
	}// end createThumbnail()
	
	
	private static String createIcon(String uploadPath,
			String fileName) {
		
		String iconName = uploadPath + File.separator 
				+ fileName;
		// 원래 파일을 리턴
		return iconName
				.substring(uploadPath.length())
				.replace(File.separatorChar, '/');
		
	} // end createIcon()
	
} // end GameImageUploadUtil
