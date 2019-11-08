defmodule TimesheetSpaWeb.SheetView do
  use TimesheetSpaWeb, :view
  alias TimesheetSpaWeb.SheetView

  def render("index.json", %{sheets: sheets}) do
    %{data: render_many(sheets, SheetView, "sheet.json")}
  end

  def render("show.json", %{sheet: sheet}) do
    %{data: render_one(sheet, SheetView, "sheet.json")}
  end

  def render("sheet.json", %{sheet: sheet}) do
    %{id: sheet.id,
      total_hours: sheet.total_hours}
  end
end
