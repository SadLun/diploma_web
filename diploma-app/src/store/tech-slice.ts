import { createAsyncThunk, createSlice, PayloadAction } from "@reduxjs/toolkit";

export interface Device {
    id: string;
    name: string;
    description: string;
    price: number;
    image: string;
    rating: number;
}

interface DeviceState {
    devices: Device[];
    isLoading: boolean;
    error: string | null;
}

const initialState: DeviceState = {
    devices: [],
    isLoading: false,
    error: null,
};

export const fetchDevices = createAsyncThunk("devices/fetchDevices", async () => {
    await new Promise((resolve) => setTimeout(resolve, 1000));
    const mockDevices: Device[] = [
        {
            id: "1",
            name: "Device 1",
            description: "Description 1",
            price: 100,
            image: "https://placehold.co/600x400",
            rating: 5
        },
        {
            id: "2",
            name: "Device 2",
            description: "Description 2",
            price: 200,
            image: "https://placehold.co/600x400",
            rating: 4
        },
    ];
    return mockDevices;
    }); // Нужно добавить работу с АПИ для получения данных с сервера (после парсинга доки)


const deviceSlice = createSlice({
    name: "devices",
    initialState,
    reducers: {
        addDevice: (state, action: PayloadAction<{name: string, description: string, price: number, image: string}>) => {
            const newDevice = {
                id: Date.now().toString(),
                name: action.payload.name,
                description: action.payload.description,
                price: action.payload.price,
                image: action.payload.image,
                rating: 5
            }
            state.devices.push(newDevice);
        },
        removeDevice: (state, action: PayloadAction<string>) => {
            state.devices = state.devices.filter((device) => device.id !== action.payload);
        },
        updateDevice: (state, action: PayloadAction<{id: string, name: string, description: string, price: number, image: string}>) => {
            const updatedDevice = {
                name: action.payload.name,
                description: action.payload.description,
                price: action.payload.price,
                image: action.payload.image
            }
            state.devices = state.devices.map((device) => device.id === action.payload.id ? {...device, ...updatedDevice} : device);
        },
    },
    extraReducers: (builder) => {
        builder
            .addCase(fetchDevices.pending, (state) => {
                state.isLoading = true;
                state.error = null;
            })
            .addCase(fetchDevices.fulfilled, (state, action) => {
                state.isLoading = false;
                state.devices = action.payload;
            })
            .addCase(fetchDevices.rejected, (state, action) => {
                state.isLoading = false;
                state.error = action.error.message || "Something went wrong";
            });
    },
});

export const { addDevice, removeDevice, updateDevice } = deviceSlice.actions;
export default deviceSlice.reducer;