<template>
  <div style="width: 50%; margin: 30px auto">
    <div style="color: #666666; font-size: 16px">欢迎理性发帖</div>
    <div style="margin-top: 20px">
      <el-input type="textarea" :rows="4" v-model="content" placeholder="请输入您的想法ddddd"></el-input>
    </div>
    <div style="margin-top: 20px; text-align: right">
      <el-button style="padding: 10px 50px" type="primary" @click="commit">提交</el-button>
    </div>
    <div style="font-size: 16px; margin-top: 30px; font-weight: bold; color: #666666">
      历史帖子：{{ tableData.length }}
    </div>
    <div style="margin-top: 20px">
      <el-table :data="tableData" stripe>
        <el-table-column prop="content" label="发帖内容" show-overflow-tooltip></el-table-column>
        <el-table-column prop="time" label="发帖时间" width="150px" show-overflow-tooltip></el-table-column>
        <el-table-column prop="name" label="业主姓名" width="100px"></el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      content: null,
      tableData: []
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      this.$request.get('/fixed/selectAll').then(res => {
        if (res.code === '200') {
          this.tableData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    commit() {
      let data = {
        content: this.content
      }
      this.$request.post('/fixed/add', data).then(res => {
        if (res.code === '200') {
          this.$message.success('提交成功，感谢您的发言')
          this.content = null
          this.load()
        } else {
          this.$message.error(res.msg)
        }
      })
    }
  }
}
</script>

<style scoped>

</style>
