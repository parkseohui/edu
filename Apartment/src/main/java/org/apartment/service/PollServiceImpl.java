package org.apartment.service;


import java.util.List;

import org.apartment.domain.PollChartVO;
import org.apartment.domain.PollDetailVO;
import org.apartment.domain.PollLookupVO;
import org.apartment.domain.PollOptionVO;
import org.apartment.domain.PollSelectVO;
import org.apartment.domain.PollVO;
import org.apartment.mapper.PollMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class PollServiceImpl implements PollService {

	private PollMapper mapper;

	@Override
	public void PollInsert(PollVO poll) {
		log.info("PollInsert......" + poll);
		mapper.PollInsert(poll);
	}

	@Override
	public List<PollVO> PollList(int aptSeq) {
		log.info("PollList......");
		return mapper.PollList(aptSeq);
	}

	@Override
	public List<PollVO> PollOnList(int aptSeq) {
		log.info("PollOnList....");
		return mapper.PollOnList(aptSeq);
	}

	@Override
	public List<PollVO> PollEndList(int aptSeq) {
		log.info("PollEndList....");
		return mapper.PollEndList(aptSeq);
	}

	@Override
	public void PollOptionInsert(List<PollOptionVO> option) {
		log.info("PollOptionInsert......");
		mapper.PollOptionInsert(option);
	}

	@Override
	public List<PollOptionVO> PollOptionList(int pollSeq) {
		log.info("PollOptionList.........");
		return mapper.PollOptionList(pollSeq);
	}

	@Override
	public void PollSelectInsert(PollSelectVO select, PollLookupVO lookup) {
//		int result = mapper.PollSelectLookup(lookup);
//		System.out.println("result : "+ result);
//		if(result == 0){
//			return -1;
//		}else {
//			System.out.println("select: "+select);
			mapper.PollSelectInsert(select);
		}
//	}

	@Override
	public List<PollDetailVO> PollDetail(int pollSeq) {
		log.info("PollDatail....");
		return mapper.PollDetail(pollSeq);
	}

	@Override
	public List<PollChartVO> PollChart(int pollSeq) {
		log.info("PollChart");
		return mapper.PollChart(pollSeq);
	}

	@Override
	public int PollSelectLookup(PollLookupVO lookup) {
		log.info("PollSelectLookup");
		return mapper.PollSelectLookup(lookup);
	}

}
