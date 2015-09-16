module ActiveModel
  class Errors

    def as_json(options={})
        self.tree.messages.each do |key, value|
          value.each_with_index do |v,i|
            set_details(self.tree.details, key, v, i)
          end
        end
        details
    end

    def set_details(details, up_key, up_v, up_i)
      if !up_v.is_a? Hash
        details[up_key][up_i][:message] = up_v
      else
        up_v.each do |key, value|
          value.each_with_index do |v, i|
            if v.is_a? Hash
              set_details(details, key,v,i)
            else
              details[up_key][up_i][key][i][:message] = v
            end
          end
        end
      end
    end
  end
end
