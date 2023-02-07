import path from 'path';

export default {
  entry: './index.js',
  output: {
            filename: 'app.js',
            path: path.resolve(process.cwd(), 'dist')
    }
};
