module Policial
  # Public: Comment violations on pull request.
  class Commenter
    def initialize(pull_request)
      @pull_request = pull_request
    end

    def comment_violation(violation)
      api.create_pull_request_comment(
        @pull_request.repo,
        @pull_request.number,
        comment_body(violation),
        @pull_request.head_commit.sha,
        violation.filename,
        violation.line_number
      )
    end

    private

    def api
      @api ||= GitHubApi.new
    end

    def comment_body(violation)
      violation.messages.join('<br/>')
    end
  end
end
