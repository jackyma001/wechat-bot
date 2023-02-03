import { ChatGPTAPI } from 'chatgpt'
import dotenv from 'dotenv'

const env = dotenv.config().parsed // 环境参数

// 定义ChatGPT的配置
const config = {
  apiKey: process.env.OPENAI_API_KEY
}
const api = new ChatGPTAPI(config)

// 获取 chatGPT 的回复
export async function getChatGPTReply(content, conversationId = null, id = null) {
  console.log('🚀🚀🚀 / content', content)
  // 调用chatgpt的接口
  let reply
  if (!conversationId) {
    reply = await api.sendMessage(content, {
      timeoutms: 2 * 60 * 1000,
    })
  } else {
    reply = await api.sendMessage(content, {
      conversationId: conversationId,
      parentMessageId: id,
      timeoutms: 2 * 60 * 1000,
    })
  }
  console.log('🚀🚀🚀 / reply', reply)
  return reply
}

