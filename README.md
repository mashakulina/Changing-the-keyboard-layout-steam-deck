Данный скрипт позволяет менять раскладку физ. клавиатуры (RU, EN) в `Game mode` через left ctrl+left shift/left alt+left shift на выбор.<br/>
Скрипт прописывает в файл `environment` параметры смены раскладки физ. клавиатуры.<br/>
Создает резервную копию файла `environment`, помещая его по пути `/etc` (`/etc/environment.bak`).<br/>
**ВНИМАНИЕ**! Для запуска данного скрипта нужен `sudo` пароль (пароль администратора). Если ранее пароль не был установлен, то это можно сделать через консоль, используя команду `passwd`.

## Добавление смены раскладки физ. клавиатуры
### Смена через lctrl+lshift
### Установка
1. Тапнуть правой кнопкой на [Changing_the_keyboard_layout_ctrl.desktop](https://raw.githubusercontent.com/mashakulina/Changing-the-keyboard-layout-steam-deck/main/Changing_the_keyboard_layout_ctrl.desktop) 
2. Сохранить через `Save as` (`Сохранить ссылку как`) на рабочем столе

### Запуск
1. Тапнуть два раза на файл `Changing_the_keyboard_layout_ctrl`
2. Ввести `sudo` пароль во всплывшем окне
3. Дождаться перезагрузки Steam Deck

### Смена через lalt+lshift
### Установка
1. Тапнуть правой кнопкой на [Changing_the_keyboard_layout_alt.desktop](https://raw.githubusercontent.com/mashakulina/Changing-the-keyboard-layout-steam-deck/main/Changing_the_keyboard_layout_alt.desktop) 
2. Сохранить через `Save as` (`Сохранить ссылку как`) на рабочем столе

### Запуск
1. Тапнуть два раза на файл `Changing_the_keyboard_layout_alt`
2. Ввести `sudo` пароль во всплывшем окне
3. Дождаться перезагрузки Steam Deck

## Восстановление исходного файла
Восстанавливает файл `environment` из bak файла.Удаляет старую версию файла.
### Установка
1. Тапнуть правой кнопкой на [environment_recovery.desktop](https://raw.githubusercontent.com/mashakulina/ru_locale_fix_on_steamdeck/main/environment_recovery.desktop) 
2. Сохранить через `Save as` (`Сохранить ссылку как`) на рабочем столе

### Запуск
1. Тапнуть два раза на файл `environment_recovery.desktop`
2. Ввести `sudo` пароль во всплывшем окне
3. Дождаться перезагрузки Steam Deck

## Дополнительно
После обновления Steam OS файл может быть сброшен до исходного состояния (если игра запустилась из Game mode на английском зяыке). В таком случае нужно повторить запуск `RuLocale.desktop`.
