package com.kh.ti.penalty.model.service;

import java.util.ArrayList;

import com.kh.ti.penalty.model.vo.PenaltyAttachment;
import com.kh.ti.common.PageInfo;
import com.kh.ti.penalty.model.vo.Penalty;

public interface PenaltyService {

	int insertPenalty(Penalty p, ArrayList<PenaltyAttachment> attachmentFileList);

	int getPenaltyCount(int memberId);

	ArrayList<Penalty> selectPenaltyList(PageInfo pi, int memberId);

	Penalty selectOnePenalty(int listId);

}
