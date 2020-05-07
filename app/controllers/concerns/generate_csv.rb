module GenerateCsv
  extend ActiveSupport::Concern

    def to_csv(csv_data, columns)
      CSV.generate(headers: true) do |csv|

        csv << columns

        csv_data.find_all do |record|
          csv << record
        end
      end
    end
end
