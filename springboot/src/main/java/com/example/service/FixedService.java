package com.example.service;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.example.entity.Account;
import com.example.entity.Fixed;
import com.example.exception.CustomException;
import com.example.mapper.FixedMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Random;


/**
 *
 * 投诉表业务处理
 **/
@Service
public class FixedService {

    @Resource
    private FixedMapper fixedMapper;

    /**
     * 新增
     */
    public void add(Fixed fixed) {
        if (ObjectUtil.isEmpty(fixed.getContent())) {
            throw new CustomException("-1", "发帖内容不能为空");
        }
        Account currentUser = TokenUtils.getCurrentUser();
        fixed.setName(currentUser.getName());
        fixed.setUsername(currentUser.getUsername());
        Random random = new Random();
        fixed.setNumber("E"+(100000 + random.nextInt(900000)));
        fixed.setTime(DateUtil.now());
        fixed.setAvatar(currentUser.getAvatar());
        fixedMapper.insert(fixed);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        fixedMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            fixedMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Fixed fixed) {
        fixedMapper.updateById(fixed);
    }

    /**
     * 根据ID查询
     */
    public Fixed selectById(Integer id) {
        return fixedMapper.selectById(id);
    }


    /**
     * 查询所有
     */
    public List<Fixed> selectAll(Fixed fixed) {
        return fixedMapper.selectAll(fixed);
    }

    /**
     * 分页查询
     */
    public PageInfo<Fixed> selectPage(Fixed fixed, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Fixed> list = fixedMapper.selectAll(fixed);
        return PageInfo.of(list);
    }

}