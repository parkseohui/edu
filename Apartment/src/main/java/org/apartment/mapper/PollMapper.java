package org.apartment.mapper;
import java.util.List;

import org.apartment.domain.HouseholdVO;
import org.apartment.domain.PollChartVO;
import org.apartment.domain.PollDetailVO;
import org.apartment.domain.PollLookupVO;
import org.apartment.domain.PollOptionVO;
import org.apartment.domain.PollSelectVO;
import org.apartment.domain.PollVO;

public interface PollMapper {
	public List<PollVO> PollList(int aptSeq);
	
	public List<PollVO> PollOnList(int aptSeq);
	
	public List<PollVO> PollEndList(int aptSeq);
	
	public List<PollChartVO> PollChart(int pollSeq);
	
	public void PollInsert(PollVO poll);
	
	public void PollOptionInsert(List<PollOptionVO> option);
	
	public List<PollDetailVO> PollDetail(int pollSeq);
	
	public int PollSelectLookup(PollLookupVO lookup);
	
	public void PollSelectInsert(PollSelectVO select);
	
	public List<PollOptionVO> PollOptionList(int pollSeq);
	
}
