
								// Упаковщик аргументов в массив
#macro UNIT_MACRO_ARGPACK_OFFS	var __argOffs =
#macro UNIT_MACRO_ARGPACK_READ	var __argSize = argument_count;							\
								var __argArrs = array_create(__argSize - __argOffs);	\
								for (var __i = __argOffs; __i < __argSize; ++__i)		\
									__argArrs[__i - __argOffs] = argument[__i];                                          

#macro UNIT_MACRO_ARGPACK_GET	__argArrs

								//
#macro UNIT_MACRO_UINT16_MAX	65535
#macro UNIT_MACRO_INT32_MAX		2147483647
#macro UNIT_MACRO_INT32_MIN		(-2147483648)

								//
#macro UNIT_MACRO_DEFCHAR		"▯"

#macro _                        undefined

#region __private

function UNIT_macro() {};

#endregion

