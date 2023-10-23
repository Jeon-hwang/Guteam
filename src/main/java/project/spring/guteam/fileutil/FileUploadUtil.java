package project.spring.guteam.fileutil;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class FileUploadUtil {

	private static final Logger logger =
			LoggerFactory.getLogger(FileUploadUtil.class);
	
	public static String saveUploadedFile(String uploadPath, 
			String fileName, byte[] data) throws IOException {
				
		SimpleDateFormat sdf = new SimpleDateFormat("hhmmss");
		
		String date = sdf.format(new Date());
		
		String saveName = date + "_" + fileName;
		
		String savePath = getUploadPath(uploadPath);
		
		File target = new File(uploadPath + File.separator + savePath,
				saveName);
		
		FileCopyUtils.copy(data, target);
		
		String extension = fileName.substring(fileName.lastIndexOf(".") + 1);
		
		String result = null;
		if (MediaUtil.getMediaType(extension) != null) {
			result = createThumbnail(uploadPath, savePath, saveName);
		} else {
			result = createIcon(uploadPath, savePath, saveName);
		}
		
		return result;
	}
	
	// 파일이 저장되는 폴더 이름을 날짜 형식(yyyy/MM/dd)으로 생성하기 위한 유틸
	// 상위 폴더가 생성되어 있지 않으면 하위 폴더를 생성할 수 없다
	// -> 연도 폴더 생성 -> 달 폴더 생성 -> 날짜 폴더 생성
	// 마지막 리턴은 yyyy/MM/dd 형식으로
	private static String getUploadPath(String uploadPath) {
		Calendar calendar = Calendar.getInstance();
		
		String yearPath = String.valueOf(calendar.get(Calendar.YEAR));
		logger.info("yearPath: " + yearPath);
		makeDir(uploadPath, yearPath);
		
		String monthPath = yearPath
				+ File.separator
				+ new DecimalFormat("00")
					.format(calendar.get(Calendar.MONTH) + 1);
		logger.info("monthPath: " + monthPath);
		makeDir(uploadPath, monthPath);
		
		String datePath = monthPath
				+ File.separator
				+ new DecimalFormat("00")
					.format(calendar.get(Calendar.DATE));
		logger.info("datePath: " + datePath);
		makeDir(uploadPath, datePath);

		return datePath;
	}
	
	private static void makeDir(String uploadPath, String path) {
		File dirPath = new File(uploadPath, path);
		if (!dirPath.exists()) {
			dirPath.mkdir();
			logger.info(dirPath.getPath() + " successfully created.");
		} else {
			logger.info(dirPath.getPath() + " already exists.");
		}
	}
	
	private static String createThumbnail(String uploadPath,
			String savePath, String fileName) throws IOException {
		
		String parent = uploadPath + File.separator + savePath;
		BufferedImage source = 
				ImageIO.read(new File(parent, fileName));
		BufferedImage destination = 
				Scalr.resize(source, Scalr.Method.AUTOMATIC, 
						Scalr.Mode.FIT_TO_HEIGHT, 300);
		String thumbnailName = 
				uploadPath + File.separator 
				+ savePath + File.separator
				+ "s_" + fileName;
		File thumbnail = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf('.') + 1);
		
		boolean result = ImageIO.write(destination, formatName, thumbnail);
		logger.info("create thumbnail result: " + result);
		
		return thumbnailName.substring(uploadPath.length())
				.replace(File.separatorChar, '/');
	}
	
	private static String createIcon(String uploadPath,
			String savePath, String fileName) {
		
		String iconName = uploadPath + File.separator 
				+ savePath + File.separator + fileName;
		
		return iconName
				.substring(uploadPath.length())
				.replace(File.separatorChar, '/');
		
	}
	
}
