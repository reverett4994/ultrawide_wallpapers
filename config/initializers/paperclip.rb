#REMOVES SPOOFING VALIDATION
require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
ActsAsTaggableOn.remove_unused_tags = true
