package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.entity.Account;
import com.example.entity.Post;
import com.example.mapper.PostMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 公告信息表业务处理
 **/
@Service
public class PostService {

    @Resource
    private PostMapper postMapper;

    /**
     * 新增
     */
    public void add(Post post) {
        post.setTime(DateUtil.today());
        Account currentUser = TokenUtils.getCurrentUser();
        post.setUsername(currentUser.getUsername());
        postMapper.insert(post);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        postMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            postMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Post post) {
        postMapper.updateById(post);
    }

    /**
     * 根据ID查询
     */
    public Post selectById(Integer id) {
        return postMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Post> selectAll(Post post) {
        return postMapper.selectAll(post);
    }

    /**
     * 分页查询
     */
    public PageInfo<Post> selectPage(Post post, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Post> list = postMapper.selectAll(post);
        return PageInfo.of(list);
    }

}