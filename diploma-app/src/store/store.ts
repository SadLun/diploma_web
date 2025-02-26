import { configureStore } from "@reduxjs/toolkit";
import techsReducer from "./tech-slice";

const store = configureStore({
    reducer: {
        techs: techsReducer,
    },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;

export default store;