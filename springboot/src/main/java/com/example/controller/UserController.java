package com.example.controller;


import com.example.common.Result;
import com.example.entity.User;
import com.example.service.UserService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;

@RestController
    @RequestMapping("/user")
    public class UserController {

        @Resource
        private UserService userService;

        @PostMapping("/add")
        public Result add(@RequestBody User user) {
            userService.add(user);
            return Result.success();
        }

        @PutMapping("/update")
        public Result update(@RequestBody User user) {
            userService.updateById(user);
            return Result.success();
        }

        @DeleteMapping("/delete/{id}")
        public Result delete(@PathVariable Integer id) {
            userService.deleteById(id);
            return Result.success();
        }

        @DeleteMapping("/delete/batch")
        public Result deleteBatch(@RequestBody List<Integer> ids) {
            userService.deleteBatch(ids);
            return Result.success();
        }


        @GetMapping("/selectPage")
        public Result selectPage(User user,
                                 @RequestParam(defaultValue = "1") Integer pageNum,
                                 @RequestParam(defaultValue = "10") Integer pageSize) {
            PageInfo<User> infos = userService.selectPage(user, pageNum, pageSize);
            return Result.success(infos);
        }




    }

