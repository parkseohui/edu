package org.apartment.controller;

import java.util.List;

import org.apartment.domain.Criteria;
import org.apartment.domain.CustomUser;
import org.apartment.domain.MarketReplyVO;
import org.apartment.service.MarketReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/tenant/replies/*")
@RestController
@Log4j
@AllArgsConstructor
public class MarketReplyController {
	
	private MarketReplyService service;
	
	@PostMapping(value="/new",consumes="application/json",produces={MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> marketreplycreate(@RequestBody MarketReplyVO vo, Authentication auth){

		CustomUser user = (CustomUser) auth.getPrincipal();
		vo.setReplyWriter(user.getMemberSeq());
		int insertCount=service.ReplyRegister(vo);
		log.info("reply insert count:"+insertCount);
		return insertCount==1? new ResponseEntity<>("success",HttpStatus.OK):new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping(value="/pages/{seq}/{page}",produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<MarketReplyVO>> marketreplygetList(@PathVariable("page") int page,@PathVariable("seq")int seq){
		log.info("getlist..");
		Criteria cri=new Criteria(page,10);
		log.info(cri);
		return new ResponseEntity<>(service.ReplyGetList(cri, seq),HttpStatus.OK);
	}
	
	@GetMapping(value="/{replyNo}",produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<MarketReplyVO> makretreplyget(@PathVariable("replyNo")int replyNo){
		log.info("get:"+replyNo);
		return new ResponseEntity<>(service.ReplyGet(replyNo),HttpStatus.OK);
		
	}
	
	@DeleteMapping(value="/{replyNo}",produces={MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> marketreplyremove(@PathVariable("replyNo") int replyNo){
		log.info("remove:"+replyNo);
		return service.ReplyRemove(replyNo)==1? new ResponseEntity<>("success",HttpStatus.OK):new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	@RequestMapping(method={RequestMethod.PUT,RequestMethod.PATCH},value="/{replyNo}",consumes="application/json",produces=MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> marketreplymodify(@RequestBody MarketReplyVO vo,@PathVariable("replyNo")int replyNo){
		vo.setReplyNo(replyNo);
		log.info("replyNo:"+replyNo);
		log.info("modify:"+vo);
		return service.ReplyModify(vo)==1? new ResponseEntity<>("success",HttpStatus.OK):new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
