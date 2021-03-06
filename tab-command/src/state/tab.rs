use tab_api::tab::{TabId, TabMetadata};

/// The select tab action, either by name or id
#[derive(Debug, Clone, PartialEq)]
pub enum SelectTab {
    NamedTab(String),
    Tab(TabId),
}

#[derive(Debug, Clone, PartialEq)]
pub struct SelectOrRetaskTab {
    pub name: String,
    pub env_tab: Option<TabId>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct DeselectTab {}

/// The client's selected tab state.
#[derive(Debug, Clone, PartialEq)]
pub enum TabState {
    None,
    Awaiting(String),
    Selected(TabId),
}

impl TabState {
    pub fn is_awaiting(&self, target_name: &str) -> bool {
        match self {
            TabState::None => false,
            TabState::Awaiting(name) => name.as_str() == target_name,
            TabState::Selected(_) => false,
        }
    }

    pub fn is_selected(&self, target_id: &TabId) -> bool {
        match self {
            TabState::None => false,
            TabState::Awaiting(_) => false,
            TabState::Selected(id) => id == target_id,
        }
    }
}

impl Default for TabState {
    fn default() -> Self {
        Self::None
    }
}

/// The client's selected tab state.
#[derive(Debug, Clone, PartialEq)]
pub enum TabMetadataState {
    None,
    Selected(TabMetadata),
}

impl Default for TabMetadataState {
    fn default() -> Self {
        Self::None
    }
}
