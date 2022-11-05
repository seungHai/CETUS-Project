package com.cetus.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.cetus.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
public class ImgController {
	
	private BoardService service;	
	
	@RequestMapping(value = "/upload.do", method = RequestMethod.POST)
	public void uploadimg(HttpServletRequest request,HttpServletResponse response, MultipartFile upload) throws Exception {
		log.info("upload 들어온다! ");
		
		response.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
 
        //파일 이름 가져오기
        String fileName=upload.getOriginalFilename();
        log.info(fileName);
        
        //고유한 UUID 가지게 해서 동일파일이 덮어쓰기 되지않게 함
        UUID uuid = UUID.randomUUID();
        fileName = uuid.toString() + "_" + fileName;
 
        //파일을 바이트 배열로 변환
        byte[] bytes=upload.getBytes();
 
        //이미지를 업로드할 디렉토리를 정해준다
        String uploadPath= request.getServletContext().getRealPath("resources/ckEimgTemp") + "/";
        OutputStream out=new FileOutputStream(new File(uploadPath+fileName));
        log.info(uploadPath);
        log.info(bytes);
 
        //서버에 write
        out.write(bytes);
        
        //성공여부 가져오기
        String callback=request.getParameter("CKEditorFuncNum");
        log.info(callback);
        
        //클라이언트에 이벤트 추가 (자바스크립트 실행)
        PrintWriter printWriter=response.getWriter(); //자바스크립트 쓰기위한 도구
        String fileUrl= "../resources" + "/ckEimgTemp/" + fileName;
        
        if(!callback.equals("3")) { // callback이 3일 경우만 성공한 것
        	 printWriter.println("<script>alert('이미지 업로드에 실패했습니다.');"+"</script>");

        }else {
        	 log.info("upload img 들어온다! "+fileUrl);
        	 try {
        		 Thread.sleep(3000); //3초 대기
        		 printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction("+callback+",'"+fileUrl+"','이미지가 업로드되었습니다.')"+"</script>");
    		 }catch(InterruptedException e) {
    			   e.printStackTrace();
    		  }
        }
        printWriter.flush();
	}
	
	@RequestMapping("/copy.do")
	public String move(HttpServletRequest request,HttpServletResponse response) throws Exception {
		File sourceF = new File(request.getServletContext().getRealPath("resources/ckEimgTemp"));
		File targetF = new File(request.getServletContext().getRealPath("resources/ckEimg"));
		
		File[] target_file = sourceF.listFiles();
		for (File file : target_file) {
			File temp = new File(targetF.getAbsolutePath() + File.separator + file.getName());
			 
		    FileInputStream fis = null;
			FileOutputStream fos = null;
			try {
				fis = new FileInputStream(file);
				fos = new FileOutputStream(temp) ;
				byte[] b = new byte[4096];
				int cnt = 0;
				while((cnt=fis.read(b)) != -1){
					fos.write(b, 0, cnt);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally{
				try {
					fis.close();
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return "redirect:/remove.do";
	}
	
	@RequestMapping("/remove.do")
	public String delete(HttpServletRequest request,HttpServletResponse response) throws Exception {
		File folder = new File(request.getServletContext().getRealPath("resources/ckEimgTemp"));
		service.resetFilesize();
		try {
			if(folder.exists()){
			    File[] folder_list = folder.listFiles();
					
			    for (int i = 0; i < folder_list.length; i++) {
				if(folder_list[i].isFile()) {
					folder_list[i].delete();
					log.info(folder_list[i].getName());
				}
				folder_list[i].delete();
			    }
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return "redirect:/board/regi";
	}
	
	@RequestMapping("/removeReal.do")
	public String removeReal(HttpServletRequest request,HttpServletResponse response) throws Exception {
		File folder = new File(request.getServletContext().getRealPath("resources/ckEimg"));
		Map<String, ?> paramMap = RequestContextUtils.getInputFlashMap(request);
		
		String content = (String) paramMap.get("content");
		log.info(content);
		
		try {
			if(folder.exists()){
			    File[] folder_list = folder.listFiles();
					
			    for (int i = 0; i < folder_list.length; i++) {
				if(folder_list[i].isFile() && content.contains(folder_list[i].getName())) {
					folder_list[i].delete();
					log.info(folder_list[i].getName());
				}
				//folder_list[i].delete();
			    }
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return "redirect:/board/regi";
	}
}
