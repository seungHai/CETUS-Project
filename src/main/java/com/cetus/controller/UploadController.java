package com.cetus.controller;

import java.io.File;
import java.net.URLDecoder;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cetus.domain.AttachFileDTO;
import com.cetus.domain.BoardAttachVO;
import com.cetus.domain.BoardVO;
import com.cetus.domain.FileVO;
import com.cetus.domain.UserRegVO;
import com.cetus.service.BoardService;
import com.cetus.service.UserRegService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class UploadController {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@Setter(onMethod_ = @Autowired)
	private UserRegService u_service;
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload Form!!");
	}
	@PostMapping("/uploadFormAction")
	public void uploadFormAction(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = "C:\\upload";
		
		for(MultipartFile multiparFile : uploadFile) {
			log.info("------------------");
			log.info("Upload File Name : " + multiparFile.getOriginalFilename());
			log.info("Upload File Size : " + multiparFile.getSize());
			
			File saveFile = new File(uploadFolder, multiparFile.getOriginalFilename());
			
			try {
				multiparFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
	}
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload Ajax!!");
	}
	private String getFolder() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        return str.replace("-",  File.separator);
    }
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody 
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxAction(MultipartFile[] uploadFile, Model model) {
		
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		
		String uploadFolder = "C:\\upload";
		
		// 폴더 생성 
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path : " + uploadPath);
		
		// 업로드 패스가 존재하는지 확인
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multiparFile : uploadFile) {
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			log.info("------------------");
			log.info("********************Upload File Name : " + multiparFile.getOriginalFilename());
			log.info("********************Upload File Size : " + multiparFile.getSize());
			
			log.info(service.updateFilesize(multiparFile.getSize()));
			
			if((multiparFile.getSize() / 1000) > 1000) {
				double filesize1 = multiparFile.getSize()/1000000.0;
				log.info((Math.floor(filesize1*100)/100.0) + "MB");
			}else {
				double filesize1 = multiparFile.getSize()/1000.0;
				log.info((Math.floor(filesize1*100)/100.0) + "KB");
			}
			
			String uploadFileName = multiparFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1); 
			
			log.info("only file name : " + uploadFileName);
			
			attachDTO.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				multiparFile.transferTo(saveFile);
				
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(getFolder());
				
				list.add(attachDTO);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName){
		log.info("**********************download!!!!!!!!!!!!!!!!!");
		log.info("download file : " + fileName);
		Resource resource = new FileSystemResource("C:\\upload\\" + fileName);
		log.info("resource : " + resource);
		
		String resourceName = resource.getFilename();
		
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		HttpHeaders headers = new HttpHeaders();
		
		try {
			headers.add("Content-Disposition", "attachment; filename=" + 
					new String(resourceOriginalName.getBytes("utf-8"),"ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	
	@PostMapping(value = "/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName){
		log.info("delete file : " + fileName);
		
		File file = null;
		try {
			file = new File("C:\\upload\\" + URLDecoder.decode(fileName, "utf-8"));
			log.info("***********************filelength**********************");
			service.updateFilesize(-file.length());
			if((file.length() / 1000) > 1000) {
				double filesize2 = file.length()/1000000.0;
				log.info((Math.floor(filesize2*100)/100.0) + "MB");
			}else {
				double filesize2 = file.length()/1000.0;
				log.info((Math.floor(filesize2*100)/100.0) + "KB");
			}
			file.delete();
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	}
	
	@PostMapping(value = "/userPoint")
	@ResponseBody
	public ResponseEntity<UserRegVO> userPoint(Principal pri){
		UserRegVO vo = u_service.getpointlist(pri.getName());
		log.info("userPoint!!!!!!!");
		log.info(vo);
		return new ResponseEntity<UserRegVO>(vo,HttpStatus.OK);
	}
	
	@GetMapping(value = "/chargePoint/{point}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public ResponseEntity<String> chargePoint(@PathVariable("point") int point, Principal pri){
		log.info("chargePoint!!!!!!!" + point);
		String msg = "";
		UserRegVO vo = new UserRegVO();
		vo.setId(pri.getName());
		vo.setCash(point);
		int result = u_service.chargePoint(vo);
		if(result > 0) {
			msg = "success";
		}else {
			msg = "fail";
		}
		return new ResponseEntity<String>(msg,HttpStatus.OK);
	}
	
	@PostMapping(value = "/updatePrice")
	@ResponseBody
	public ResponseEntity<FileVO> updatePrice(){
		FileVO vo = service.getFileVO();
		log.info("updatePrice!!!!!!!");
		log.info(vo);
		return new ResponseEntity<FileVO>(vo,HttpStatus.OK);
	}
	
	@PostMapping(value = "/resetFileSize")
	@ResponseBody
	public ResponseEntity<String> resetFileSize(){
		service.resetFilesize();
		return new ResponseEntity<>("success",HttpStatus.OK);
	}
}
