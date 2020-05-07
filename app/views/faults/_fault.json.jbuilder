json.extract! fault,  :id, :logbook_reference, :discovered, :discrepancy_id, :user_id, :recorded_by_id, :resolving_corrective_action_id,
                      :technician_comment, :action_carried, :logbook_text, :raised_on_flight, :confirmed, :inbound_deferred,
                      :cid, :attachment_filename, :attachment, :state, :impacted_seat_count, :seats_impacted, :raised_at,
                      :deferral_reference, :controller_comment, :aircraft_id, :activity_id, :mel_cetegory, :alert_raised,
                      :fmr, :pirep, :mcc_status, :resolved_at, :defer_quantity, :mcc_description, :defer_reason_id,
                      :approval_state, :created_at, :updated_at

json.comments fault.comments
json.url fault_url(fault, format: :json)
