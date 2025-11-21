import {DataSource} from 'typeorm'

export const AppDataSource = new DataSource({
    type: "postgres",
    host: "localhost",
    port: 5432,
    username: "university_usr",
    password: "$#UniversityBackend2025$#",
    database: "university_db",
    schema: "core",
    synchronize: false,
    logging: true,
    entities: [],
    subscribers: [],
    migrations: [],
})