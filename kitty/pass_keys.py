from subprocess import STDOUT

from kittens.tui.handler import result_handler
from kitty.key_encoding import KeyEvent, parse_shortcut



def is_window_vim(boss, window):
    vars = boss.call_remote_control(window, ('set-user-vars', f'--match=id:{window.id}'))
    for var in vars.split('\n'):
        if var.startswith('IS_NVIM'):
            return True
        else:
            return False


def encode_key_mapping(window, key_mapping):
    mods, key = parse_shortcut(key_mapping)
    event = KeyEvent(
        mods=mods,
        key=key,
        shift=bool(mods & 1),
        alt=bool(mods & 2),
        ctrl=bool(mods & 4),
        super=bool(mods & 8),
        hyper=bool(mods & 16),
        meta=bool(mods & 32),
    ).as_window_system_event()

    return window.encoded_key(event)

def main():
    pass


@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    window = boss.window_id_map.get(target_window_id)
    action = args[1]
    direction = args[2]
    key_mapping = args[3] if action == 'neighboring_window' else args[4]

    if window is None:
        return
    if is_window_vim(boss, window):
        for keymap in key_mapping.split(">"):
            encoded = encode_key_mapping(window, keymap)
            window.write_to_child(encoded)
    elif action == 'neighboring_window':
        boss.active_tab.neighboring_window(direction)
