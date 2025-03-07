package com.example.service;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.example.entity.Account;
import com.example.entity.Complaint;
import com.example.exception.CustomException;
import com.example.mapper.ComplaintMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 *
 * 投诉表业务处理
 **/
@Service
public class ComplaintService {

    @Resource
    private ComplaintMapper complaintMapper;

    /**
     * 新增
     */
    public void add(Complaint complaint) {
        if (ObjectUtil.isEmpty(complaint.getContent())) {
            throw new CustomException("-1", "投诉建议内容不能为空");
        }
        Account currentUser = TokenUtils.getCurrentUser();
        complaint.setName(currentUser.getName());
        complaint.setTime(DateUtil.now());
        complaint.setStatus("待处理");
        complaintMapper.insert(complaint);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        complaintMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            complaintMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Complaint complaint) {
        complaintMapper.updateById(complaint);
    }

    /**
     * 根据ID查询
     */
    public Complaint selectById(Integer id) {
        return complaintMapper.selectById(id);
    }
    public Complaint selectByName(String name) {
        return complaintMapper.selectByName(name);
    }

    /**
     * 查询所有
     */
    public List<Complaint> selectAll(Complaint complaint) {
        return complaintMapper.selectAll(complaint);
    }

    /**
     * 分页查询
     */
    public PageInfo<Complaint> selectPage(Complaint complaint, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Complaint> list = complaintMapper.selectAll(complaint);
        return PageInfo.of(list);
    }

}