import { getChatGPTReply as getReply } from '../chatgpt/index.js'
import * as readline from "readline"


const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

let conversationId = '';
let id = '';
var  recursiveAsyncReadLine = async ()=> {
  rl.question('Command: ', async (input) => {
    if (input == 'exit') //we need some base case, for recursion
      return rl.close(); //closing RL and returning from function.
    const reply = await getReply(input, conversationId, id)
    conversationId = reply.conversationId;
    id = reply.id;
    recursiveAsyncReadLine(); //Calling this function again to ask new question
  });
};

await recursiveAsyncReadLine(); //we have to actually start our recursion somehow
