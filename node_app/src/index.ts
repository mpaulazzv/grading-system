import "reflect-metadata";
import app from "./app.js";
import {AppDataSource} from "./db/db.js"

async function main (){
    try{
        AppDataSource.initialize();
        console.log('Database connected')
        app.listen(3000);
        console.log('server is listening on port 3000');
    }catch(error){
        console.log(error);
    }
}

main();