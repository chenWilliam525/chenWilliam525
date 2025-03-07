<template>
  <div class="container">
    <div style="width: 400px; padding: 30px; background-color: white; border-radius: 5px;">
      <div style="text-align: center; font-size: 20px; margin-bottom: 20px; color: #333">欢迎登录小区物业系统</div>
      <el-form :model="form" :rules="rules" ref="formRef">
        <el-form-item prop="username">
          <el-input prefix-icon="el-icon-user" placeholder="请输入账号" v-model="form.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input prefix-icon="el-icon-lock" placeholder="请输入密码" show-password  v-model="form.password"></el-input>
        </el-form-item>
        <el-form-item prop="role">
          <el-select v-model="form.role" placeholder="请选择角色" style="width: 100%">
            <el-option label="管理员" value="ADMIN"></el-option>
            <el-option label="业主" value="USER"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button style="width: 100%; background-color: #333; border-color: #333; color: white" @click="login">登 录</el-button>
        </el-form-item>
        <div style="display: flex; align-items: center">
          <div style="flex: 1"></div>
          <div style="flex: 1; text-align: right">
            还没有账号？请 <a href="/register">注册</a>
          </div>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      form: { role: 'ADMIN' },
      rules: {
        username: [
          { required: true, message: '请输入账号', trigger: 'blur' },
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
        ]
      }
    }
  },
  methods: {
    login() {
      this.$refs['formRef'].validate((valid) => {
        if (valid) {
          // 验证通过后进行登录请求
          this.$request.post('/login', this.form).then(res => {
            if (res.code === '200') {
              // 如果是管理员，直接跳转主页
              if (this.form.role === 'ADMIN') {
                localStorage.setItem("xm-user", JSON.stringify(res.data));  // 存储管理员数据
                this.$message.success('登录成功');
                this.$router.push('/');  // 跳转到管理员主页
              } else {
                // 如果是业主，判断 status
                const userStatus = res.data.status;
                if (userStatus === '已通过' || userStatus === '已同意') {
                  // status 为 已通过 或 已同意，允许登录
                  localStorage.setItem("xm-user", JSON.stringify(res.data));  // 存储业主数据
                  this.$message.success('登录成功');
                  this.$router.push('/front/home');  // 跳转到用户主页
                } else if (userStatus === '待审核') {
                  this.$message.warning('您的账号正在审核中，请耐心等待');
                } else if (userStatus === '已拒绝') {
                  this.$message.error('您的账号已被拒绝，请联系管理员');
                }
              }
            } else {
              this.$message.error(res.msg);
            }
          }).catch(error => {
            this.$message.error('登录失败，请稍后重试');
          });
        }
      });
    }
  }
}
</script>

<style scoped>
.container {
  height: 100vh;
  overflow: hidden;
  background-image: url("@/assets/imgs/bg.jpg");
  background-size: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
}
a {
  color: #2a60c9;
}
</style>
