
<template>
  <div style="width: 50%; margin: 30px auto">
    <div style="color: #666666; font-size: 16px">欢迎发表您宝贵的意见，我们会认真考虑</div>
    <div style="margin-top: 20px">
      <el-input type="textarea" :rows="4" v-model="content" placeholder="请输入您的投诉或者建议"></el-input>
    </div>
    <div style="margin-top: 20px; text-align: right">
      <el-button style="padding: 10px 50px" type="primary" @click="commit">提交</el-button>
    </div>
    <div style="font-size: 16px; margin-top: 30px; font-weight: bold; color: #666666">
      历史反馈的问题：{{ tableData.length }}
    </div>
    <div style="margin-top: 20px">
      <el-table :data="tableData" stripe>
        <el-table-column prop="content" label="反馈内容" show-overflow-tooltip></el-table-column>
        <el-table-column prop="time" label="提交时间" width="150px" show-overflow-tooltip></el-table-column>
        <el-table-column prop="name" label="业主姓名" width="100px"></el-table-column>
        <el-table-column prop="status" label="处理状态" width="100px">
          <template v-slot="scope">
            <el-tag type="success" v-if="scope.row.status === '已处理'">已处理</el-tag>
            <el-tag type="danger" v-else>待处理</el-tag>
          </template>
        </el-table-column>
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
      this.$request.get('/complaint/selectAll').then(res => {
        if (res.code === '200') {
          this.tableData = res.data.filter(item=>item.name===this.user.name)
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    commit() {
      let data = {
        content: this.content
      }
      this.$request.post('/complaint/add', data).then(res => {
        if (res.code === '200') {
          this.$message.success('反馈成功，我们会认真考虑您反馈的信息')
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
