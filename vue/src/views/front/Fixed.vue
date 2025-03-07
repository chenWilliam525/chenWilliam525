<template>
    <div style="width: 80%; margin: 30px auto">
        <div style="color: #666666; font-size: 16px">欢迎理性发帖</div>
        <div style="margin-top: 20px">
            <el-input type="textarea" :rows="4" v-model="content" placeholder="请输入您的想法"></el-input>
        </div>
        <div style="margin-top: 20px; text-align: right">
            <el-button style="padding: 10px 50px" type="primary" @click="commit">提交</el-button>
        </div>

        <div style="font-size: 16px; margin-top: 30px; font-weight: bold; color: #666666">
            历史帖子：{{ tableData.length }}
        </div>

        <div v-for="(item, index) in tableData" :key="item.id" class="post">
            <div class="post-header">
                <el-image
                        v-if="item.avatar"
                        :src="item.avatar"
                        :preview-src-list="[item.avatar]"
                        style="width: 40px; height: 40px; border-radius: 50%; margin-right: 10px"
                ></el-image>
                <div class="post-info">
                    <div class="username">{{ item.username }}</div>
                    <div class="post-time">{{ item.time }}</div>
                </div>
            </div>
            <div class="post-body">
                <div class="post-content">{{ item.content }}</div>
            </div>

            <!-- 回复部分 -->
            <div v-if="item.showReply" class="reply-section">
                <el-input type="textarea" :rows="2" v-model="item.replyContent" placeholder="输入您的回复"></el-input>
                <div style="margin-top: 10px; text-align: right">
                    <el-button type="primary" @click="submitReply(index)">回复</el-button>
                </div>
            </div>
            <el-button size="small" @click="toggleReply(index)">回复</el-button>

            <!-- 显示回复 -->
            <div v-if="item.replies && item.replies.length > 0" class="replies">
                <div v-for="(reply, replyIndex) in item.replies" :key="replyIndex" class="reply">
                    <div class="reply-header">
                        <el-image
                                v-if="reply.avatar"
                                :src="reply.avatar"
                                :preview-src-list="[reply.avatar]"
                                style="width: 30px; height: 30px; border-radius: 50%; margin-right: 10px"
                        ></el-image>
                        <div class="reply-info">
                            <div class="reply-username">{{ reply.username }}</div>
                            <div class="reply-time">{{ reply.time }}</div>
                        </div>
                    </div>
                    <div class="reply-content">{{ reply.content }}</div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
  data() {
    return {
      content: '', // 发表的内容
      tableData: [], // 存储帖子数据
      user: JSON.parse(localStorage.getItem('xm-user') || '{}') // 当前用户信息
    };
  },
  created() {
    this.loadPosts(); // 加载帖子数据
  },
  methods: {
    // 加载历史帖子数据
    loadPosts() {
      this.$request.get('/fixed/selectAll').then(res => {
        if (res.code === '200') {
          this.tableData = res.data.map(item => ({
            ...item,
            showReply: false, // 控制回复输入框显示
            replyContent: '', // 回复内容
            replies: item.replies || [] // 回复列表
          }));
        } else {
          this.$message.error(res.msg);
        }
      }).catch(error => {
        console.error("加载帖子失败:", error);
      });
    },

    // 提交新的帖子
    commit() {
      if (!this.content) {
        this.$message.error('请输入帖子内容');
        return;
      }

      let data = {
        content: this.content
      };

      this.$request.post('/fixed/add', data).then(res => {
        if (res.code === '200') {
          this.$message.success('提交成功，感谢您的发言');
          this.content = ''; // 清空输入框
          this.loadPosts(); // 重新加载帖子列表
        } else {
          this.$message.error(res.msg);
        }
      }).catch(error => {
        console.error("提交帖子失败:", error);
      });
    },

    // 切换回复输入框显示与否
    toggleReply(index) {
      this.tableData[index].showReply = !this.tableData[index].showReply;
    },

    // 提交回复
    submitReply(index) {
      const replyContent = this.tableData[index].replyContent;
      if (!replyContent) {
        this.$message.error('请输入回复内容');
        return;
      }

      const newReply = {
        content: replyContent,
        avatar: this.user.avatar || '', // 当前用户的头像
        username: this.user.username || '匿名', // 当前用户的用户名（或昵称）
        time: this.formatTime(new Date()) // 回复时间
      };

      // 将回复内容添加到该帖子的回复列表中
      this.tableData[index].replies.push(newReply);
      this.tableData[index].replyContent = ''; // 清空回复内容
      this.tableData[index].showReply = false; // 隐藏回复框
      this.$message.success('回复成功');

      // 如果需要，可以将回复同步到服务器
      // const replyData = {
      //   postId: this.tableData[index].id,
      //   replyContent: replyContent,
      //   userId: this.user.id
      // };
      // this.$request.post('/fixed/reply', replyData).then(res => {
      //   if (res.code === '200') {
      //     this.$message.success('回复成功');
      //   } else {
      //     this.$message.error(res.msg);
      //   }
      // }).catch(error => {
      //   console.error("回复失败:", error);
      // });
    },

    // 格式化时间为 yyyy-MM-dd hh:mm:ss
    formatTime(date) {
      const yyyy = date.getFullYear();
      const mm = (date.getMonth() + 1).toString().padStart(2, '0');
      const dd = date.getDate().toString().padStart(2, '0');
      const hh = date.getHours().toString().padStart(2, '0');
      const min = date.getMinutes().toString().padStart(2, '0');
      const ss = date.getSeconds().toString().padStart(2, '0');
      return `${yyyy}-${mm}-${dd} ${hh}:${min}:${ss}`;
    }
  }
};
</script>

<style scoped>
.post {
  border: 1px solid #e0e0e0;
  margin-top: 20px;
  padding: 15px;
  background-color: #f9f9f9;
  border-radius: 8px;
}

.post-header {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.post-info {
  display: flex;
  flex-direction: column;
}

.username {
  font-weight: bold;
  color: #333;
}

.post-time {
  font-size: 12px;
  color: #888;
}

.post-body {
  margin-top: 10px;
}

.post-content {
  font-size: 14px;
  line-height: 1.5;
  color: #333;
}

.reply-section {
  margin-top: 10px;
}

.replies {
  margin-top: 15px;
}

.reply {
  margin-bottom: 8px;
  padding: 10px;
  background-color: #f1f1f1;
  border-radius: 5px;
}

.reply-header {
  display: flex;
  align-items: center;
  margin-bottom: 5px;
}

.reply-info {
  display: flex;
  flex-direction: column;
}

.reply-username {
  font-weight: bold;
  color: #333;
}

.reply-time {
  font-size: 12px;
  color: #888;
}

.reply-content {
  font-size: 14px;
  color: #555;
}
</style>
