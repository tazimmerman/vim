"
" Purpose:  C++ syntax coloring for STL and Boost functions and types
" Author:   Troy Zimmerman (thanks to Jean-Francois Guchens [script #2224] and Nathan Skvirsky [script #1640])
" Modified: 9/24/2008
"

syn keyword cppSTLfunction  accumulate adjacent_difference adjacent_find advance binary_search construct copy copy_backward copy_n count count_if destroy distance distance_type equal equal_range fill fill_n find find_end find_first_of find_if for_each generate generate_n get_temporary_buffer includes inner_product inplace_merge iota is_heap is_sorted iter_swap iterator_category lexicographical_compare lexicographical_compare_3way lower_bound make_heap max max_element merge min min_element mismatch next_permutation nth_element partial_sort partial_sort_copy partial_sum partition pop_heap power prev_permutation ptr_fun push_heap random_sample random_sample_n random_shuffle remove remove_copy remove_copy_if remove_if replace replace_copy replace_copy_if replace_if return_temporary_buffer reverse reverse_copy rotate rotate_copy search search_n set_difference set_intersection set_symmetric_difference set_union sort sort_heap stable_partition stable_sort swap swap_ranges transform uninitialized_copy uninitialized_copy_if uninitialized_fill uninitialized_fill_n unique unique_copy upper_bound value_type
syn keyword cppSTLtype      auto_ptr back_insert_iterator basic_string bidirectional_iterator bidirectional_iterator_tag binary_compose binary_function binary_negate binder1st binder2nd bit_vector bitset cerr char_producer char_traits cin clog const_iterator const_reverse_iterator cout deque divides domain_error endl equal_to exception filebuf forward_iterator forward_iterator_tag front_insert_iterator fstream greater greater_equal hash hash_map hash_multimap hash_multiset hash_set identity ifstream input_iterator input_iterator_tag insert_iterator invalid_argument ios iostream istream istream_iterator istringstream iterator iterator_traits length_error less less_equal list logic_error logical_and logical_not logical_or map mem_fun1_ref_t mem_fun1_t mem_fun_ref_t mem_fun_t minus modulus multimap multiplies multiset negate not_equal_to ofstream ostream ostream_iterator ostringstream out_of_range output_iterator output_iterator_tag overflow_error pair plus pointer_to_binary_function pointer_to_unary_function priority_queue project1st project2nd queue random_access_iterator random_access_iterator_tag range_error raw_storage_iterator reverse_bidirectional_iterator reverse_iterator rope runtime_error select1st select2nd set sequence_buffer size_type slist stack streambuf string stringbuf stringstream subtractive_rng temporary_buffer unary_compose unary_function unary_negate underflow_error vector wstring

syn keyword cppBOOSTfunction  bind call_once cref ref
syn keyword cppBOOSTtype      barrier condition_variable condition_variable_any function intrusive_ptr lock_guard mutex once_flag recursive_mutex recursive_timed_mutex scoped_array scoped_ptr shared_array shared_lock shared_mutex shared_ptr thread thread_group thread_specific_ptr timed_mutex unique_lock upgrade_lock upgrade_to_unique_lock weak_ptr

if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppSTLfunction    Identifier
  HiLink cppSTLtype        Type
  HiLink cppBOOSTfunction  Identifier
  HiLink cppBOOSTtype      Type
  delcommand HiLink
endif
