module BooleanHelper
  def boolean_checkmark(boolean)
    if boolean
      "<svg class='h-5 w-5 fill-current text-white bg-thales-green rounded-full p-1' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 20 20'>
        <path d='M0 11l2-2 5 5L18 3l2 2L7 18z'/>
      </svg>".html_safe
    else
      "<div class='h-5 w-5 fill-current text-white bg-gray-400 rounded-full p-1'></div>".html_safe
    end
  end
end
