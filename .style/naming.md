## Стиль именования идентификаторов, который я стараюсь придерживатся

### Skip - пустые имена
Используется для обозначения неиспользуемых идентификаторов (в некоторых языках для этого используется `_`)  

Общий стиль: `_` + `число`

Примеры:
```js
...
  try {
  ...
  }
  catch(_0) {
    return undefined;
  }
...
```

```js
regist(function(_0, _1, _data) {
  show_debug_message(_data.name);
}, { name: "TEST" });
```

### Res - префиксы/идентификаторы ресурсов
Используется для обозначение вида ресурсов  

**Не допускается использовать MACRO_CASE**

* `spr` - sprite
* `scr` - script
* `obj` - object
* `ex` - extension
* `sq` - sequence
* `sh` - shader
* `sn` - sound
* `fn` - font
* `rm` - room
* `cv` - animation curve (CurVe)
* `pt` - path
* `tl` - timeline
* `ts` - tile set

Примеры:
```gml
var _resources = [
  spr_player,
  objEnemy,
  // FN_MAIN, - не правильно
  PackMainObjPlayer,
  PackMainSprEnemy,
  __rmTest,
  __objTest,
  __TOOL_read, // не обязательно обозначать тип ресурса
  TOOL_write,  //
];
```

### LPub, GPub - локально/глобально-публичные имена
**Не допускается использовать MACRO_CASE**  
**Не допускается использовать PascalCase**

Общий стиль: `буква` + `буквы|цифры|(символы _)...`  

Примеры:
```gml
user_a = "user";
Name = "Kirill";
function userPrint() {};
// function PRINT() {}; - не правильно
// function HelloWorld() {}; - не правильно

global.user = user_a;
// global.PRINT = undefined; - не правильно
// global.Print = undefined; - не правильно
```

### LPrv, GPrv - локально/глобально-приватные имена
**Не допускается использовать MACRO_CASE**  
**Не допускается использовать PascalCase**

Общий стиль: `__` + `буквы|цифры|(символы _)...`  

Примеры:
```gml
__user_a = "user";
__Name = "Kirill";
function __userPrint() {};
// function __PRINT() {}; - не правильно
// function __HelloWorld() {}; - не правильно

global.__user = __user_a;
// global.__PRINT = undefined; - не правильно
// global.__Print = undefined; - не правильно
```

### Constructor - конструкторы
Используется для конструкций: `function id() constructor {};` и `function id(): parent() constructor {};`  

**Допускается использование только PascalCase**  

Общий стиль для публичных: `буква` + `буквы|цифры|(символы _)...`  
Общий стиль для приватных: `__` + `буквы|цифры|(символы _)...`  

Примеры:
```gml
function Vec(): __Vec() constructor {};
function __Vec() constructor {};
```

### Macro - макросы
**Допускается использование только MACRO_CASE**  

Общий стиль для публичных: `буква` + `буквы|цифры|(символы _)...`  
Общий стиль для приватных: `__` + `буквы|цифры|(символы _)...`  

Примеры:
```gml
#macro LOOP for(;;)
#macro __IF_LOAD (load() != undefined)
```

### Enum - перечисления

Для идентификатора:
* **Допускается использование только MACRO_CASE**  
* Общий стиль для публичных: `_` + `буквы|цифры|(символы _)...`  
* Общий стиль для приватных: `___` + `буквы|цифры|(символы _)...`  

Для ключа:
* Общий стиль для публичных: `_` + `буквы|цифры|(символы _)...`  

Примеры:
```gml
enum _STATE { _Walk, _Idle };
enum ___KEYS { _x, _y, _time, _lost_time };
```

### Var - временные переменные
**Не допускается использовать MACRO_CASE**  
Общий стиль для публичных: `_` + `буквы|цифры|(символы _)...`  

Примеры:
```gml
var _key = "name";
var _State = 0xFF;
function get_json(_path) { ... };
```

### globalvar
**В общем случаи не определено**  
Рекомендуется использовать только для именования публичных идентификаторов (начинающихся с буквы), и использованием **PascalCase** и **shake_case**
