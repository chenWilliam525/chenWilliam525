package com.example.service;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.example.entity.Account;
import com.example.entity.Examine;
import com.example.exception.CustomException;
import com.example.mapper.ExamineMapper;
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
public class ExamineService {

    @Resource
    private ExamineMapper examineMapper;

    /**
     * 新增
     */
    public void add(Examine examine) {
        if (ObjectUtil.isEmpty(examine.getContent())) {
            throw new CustomException("-1", "投诉建议内容不能为空");
        }
        Account currentUser = TokenUtils.getCurrentUser();
        examine.setName(currentUser.getName());
        examine.setTime(DateUtil.now());
        examine.setStatus("待处理");
        examineMapper.insert(examine);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        examineMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            examineMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Examine examine) {
        examineMapper.updateById(examine);
    }

    /**
     * 根据ID查询
     */
    public Examine selectById(Integer id) {
        return examineMapper.selectById(id);
    }
    public Examine selectByName(String name) {
        return examineMapper.selectByName(name);
    }

    /**
     * 查询所有
     */
    public List<Examine> selectAll(Examine examine) {
        return examineMapper.selectAll(examine);
    }

    /**
     * 分页查询
     */
    public PageInfo<Examine> selectPage(Examine examine, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Examine> list = examineMapper.selectAll(examine);
        return PageInfo.of(list);
    }

}