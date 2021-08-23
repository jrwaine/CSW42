import argparse
import sys
import socket
import tkinter
from typing import Optional
from typing_extensions import IntVar

import numpy as np
import seaborn as sns

from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from matplotlib.figure import Figure


IP_SERVER = "localhost"
PORT_SERVER = 8008
ONLY_TEST = False
SEED_SET = False
MAX_GEN_SIZE = 1024
NUMBERS_RCV = np.empty((0,), dtype=np.uint32)
N_MSB_CONSIDER = 4

def send_msg_rcv_data(b: bytes, rcv_size: int) -> Optional[bytes]:
    global BUFF_SIZE, IP_SERVER, PORT_SERVER

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((IP_SERVER, PORT_SERVER))
    s.send(b)
    data_ret: Optional[bytes] = None
    if(rcv_size > 0):
        data_ret = s.recv(rcv_size)
    s.close()
    return data_ret

def decode_msg(b: bytes) -> np.ndarray:
    np_arr = np.array(np.frombuffer(b, dtype=np.uint32))
    return np_arr


def plot_numbers_rcv():
    global NUMBERS_RCV

    data_plot = NUMBERS_RCV
    print(len(data_plot))
    fig = Figure()
    ax = fig.subplots()
    sns.histplot(data_plot, ax=ax)

    ax.set_title(f"Distribution ({len(NUMBERS_RCV)} generated)")
    # fig.savefig(f"csr31/plots/{msg}_{side}.png")
    return fig


def crete_client_interface():
    window = tkinter.Tk()
    window.title(f"Client")
    window.geometry("720x720")

    seed_field = tkinter.Label(window, text=f"Seed")
    seed_field.grid(column=0, row=0)
    seed_field_res = tkinter.Entry(window, width=20)
    seed_field_res.grid(column=1, row=0)

    n_rand_field = tkinter.Label(window, text=f"Nº of randoms")
    n_rand_field.grid(column=0, row=1)
    n_rand_field_res = tkinter.Entry(window, width=20)
    n_rand_field_res.grid(column=1, row=1)

    def send_socket_cmd(data_snd, rcv_data: bool) -> Optional[bytes]:
        data_rcv = send_msg_rcv_data(data_snd, rcv_data)
        return data_rcv

    def send_seed():
        str_field = seed_field_res.get()
        data_snd = np.uint32(str_field).tobytes()
        send_socket_cmd(data_snd, 0)

    def send_n_rand():
        global MAX_GEN_SIZE
        str_field = n_rand_field_res.get()
        number_snd = np.uint32(str_field)
        data_snd = number_snd.tobytes()
        if(number_snd > MAX_GEN_SIZE):
            tkinter.messagebox.showerror(
                title="Error", 
                message=f"N rand must be at max {MAX_GEN_SIZE}")
            return
        data = send_socket_cmd(data_snd, number_snd*4)
        update_plot_arr(data)

    def update_plot_arr(data_rcv: bytes):
        global NUMBERS_RCV
        print(len(data_rcv))
        arr_rcv = np.frombuffer(data_rcv, dtype=np.uint32)
        NUMBERS_RCV = np.append(NUMBERS_RCV, arr_rcv, axis=0)
        figure = plot_numbers_rcv()
        canvas = FigureCanvasTkAgg(figure, window)
        canvas.get_tk_widget().grid(column=0, row=6, columnspan=3)
        canvas.draw()

    btn_send = tkinter.Button(window, text="Send seed", command=send_seed)
    btn_send.grid(column=0, row=2)
    btn_send = tkinter.Button(window, text="Send n rand", command=send_n_rand)
    btn_send.grid(column=1, row=2)

    window.mainloop()


def run_client():
    print("running client")
    crete_client_interface()

def main():
    run_client()


if __name__ == "__main__":
    main()
